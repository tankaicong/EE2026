"""
Training script for TinyissimoYOLO on the WiderFace dataset.

Usage notes:
  1. Download WiderFace images and annotations. Place images under a folder
     e.g. `WIDER_train/images/` and the annotation file (wider_face_train_bbx_gt.txt)
     somewhere accessible.

     WiderFace download brief:
       - Images: https://drive.google.com/drive/folders/1__... (WIDER_train images)
       - Annotations: available within the WIDER dataset repository, specifically
         `wider_face_split/wider_face_train_bbx_gt.txt`.

     Practical instruction:
       - Download WIDER_train images and extract to `/path/to/WIDER_train/images/`
       - Copy `wider_face_train_bbx_gt.txt` to `/path/to/WIDER_train/annotation.txt`

  2. Run training:
       python3 train_widerface.py --images /path/to/WIDER_train/images/ --ann /path/to/WIDER_train/annotation.txt

This script does a minimal YOLO-style target encoding (assign at most one
object per grid cell) and a simple loss combining:
  - bbox MSE for cells with objectness
  - objectness BCE
  - class BCE (supports multi-class but WiderFace is single-class)

This is intentionally simple and designed for quick experiments before
implementing the model on FPGA.
"""

from __future__ import annotations

import argparse
import math
import os
from typing import List, Tuple, Optional

from PIL import Image, ImageOps
import torch
import torch.nn as nn
from torch.utils.data import DataLoader, Dataset
import torch.nn.functional as F
from torchvision import transforms

from cnn import TinyissimoYOLO


class WiderFaceDataset(Dataset):
    """Parser for WiderFace training annotations.

    Expects the classic `wider_face_train_bbx_gt.txt` format where entries are:
      image_relative_path
      number_of_faces
      x y w h blur expression ...   (repeated per face)

    We keep only the first 4 values (x, y, w, h) per box and ignore flags.
    Images are resized to `img_size` (88x88 by default).
    """

    def __init__(self, images_root: str, ann_file: str, img_size: int = 88, transform=None, augment: bool = False, hflip_p: float = 0.5):
        super().__init__()
        self.images_root = images_root
        self.img_size = img_size
        self.transform = transform or transforms.Compose([
            transforms.Resize((img_size, img_size)),
            transforms.ToTensor(),
        ])
        self.augment = augment
        self.hflip_p = hflip_p

        self.samples: List[Tuple[str, List[Tuple[float, float, float, float]]]] = []
        self._load_annotations(ann_file)

    def _load_annotations(self, ann_file: str) -> None:
        with open(ann_file, 'r') as f:
            lines = [ln.strip() for ln in f.readlines() if ln.strip()]

        i = 0
        while i < len(lines):
            img_rel = lines[i]
            i += 1
            if i >= len(lines):
                break
            try:
                nboxes = int(lines[i])
            except Exception:
                # defensive: if parse fails, skip
                break
            i += 1
            boxes = []
            for _ in range(nboxes):
                parts = lines[i].split()
                i += 1
                if len(parts) >= 4:
                    x, y, w, h = map(float, parts[:4])
                    boxes.append((x, y, w, h))
            self.samples.append((img_rel, boxes))

    def __len__(self) -> int:
        return len(self.samples)

    def __getitem__(self, idx: int):
        img_rel, boxes = self.samples[idx]
        img_path = os.path.join(self.images_root, img_rel)
        img = Image.open(img_path).convert('RGB')
        w0, h0 = img.size
        # Optional horizontal flip augmentation (before resize)
        if self.augment and torch.rand(1).item() < self.hflip_p:
            img = ImageOps.mirror(img)
            # Adjust boxes: cx' = 1 - ((bx+bw/2)/W), we'll do after rescale
            flipped = True
        else:
            flipped = False

        x = self.transform(img)

        # rescale boxes to resized image
        scale_x = self.img_size / float(w0)
        scale_y = self.img_size / float(h0)
        boxes_rescaled = []
        for (bx, by, bw, bh) in boxes:
            cx = (bx + bw / 2.0) * scale_x
            cy = (by + bh / 2.0) * scale_y
            bw_s = bw * scale_x
            bh_s = bh * scale_y
            # normalize to [0,1]
            nx = cx / self.img_size
            ny = cy / self.img_size
            nw = bw_s / self.img_size
            nh = bh_s / self.img_size
            if flipped:
                nx = 1.0 - nx
            boxes_rescaled.append((nx, ny, nw, nh))

        return x, boxes_rescaled


def encode_targets(boxes: List[Tuple[float, float, float, float]], S: int, B: int, C: int) -> torch.Tensor:
    """Encode a list of normalized boxes to an SxSx(B*5 + C) target tensor.

    boxes: list of (cx, cy, w, h) normalized to [0,1]
    Strategy: for each box, find cell (i,j) by cx,cy. If multiple boxes map to
    same cell, we keep only the first (simple).
    We assign to the first available box-slot (0..B-1); if none available, skip.
    """
    per_cell = B * 5 + C
    target = torch.zeros(S, S, per_cell, dtype=torch.float32)

    for (cx, cy, bw, bh) in boxes:
        if not (0.0 <= cx <= 1.0 and 0.0 <= cy <= 1.0):
            continue
        gx = cx * S
        gy = cy * S
        cell_x = min(max(int(gx), 0), S - 1)
        cell_y = min(max(int(gy), 0), S - 1)
        # tx,ty are offsets within cell [0,1)
        tx = gx - cell_x
        ty = gy - cell_y

        # find a box slot
        slot_found = False
        for b in range(B):
            off = b * 5
            if target[cell_y, cell_x, off + 4] == 0:  # obj flag free
                target[cell_y, cell_x, off + 0] = tx
                target[cell_y, cell_x, off + 1] = ty
                target[cell_y, cell_x, off + 2] = bw
                target[cell_y, cell_x, off + 3] = bh
                target[cell_y, cell_x, off + 4] = 1.0  # objectness
                slot_found = True
                break
        if not slot_found:
            # drop this box if no slot
            continue

        # classes: WiderFace is single class; set as 1.0 if object exists
        class_start = B * 5
        target[cell_y, cell_x, class_start:class_start + C] = 1.0

    return target


class TinyYOLOLoss(nn.Module):
    def __init__(self, S: int, B: int, C: int, lambda_coord: float = 5.0, lambda_noobj: float = 0.5):
        super().__init__()
        self.S = S
        self.B = B
        self.C = C
        self.lambda_coord = lambda_coord
        self.lambda_noobj = lambda_noobj

        self.mse = nn.MSELoss(reduction='sum')
        self.bce_logits = nn.BCEWithLogitsLoss(reduction='sum')

    def forward(self, preds: torch.Tensor, targets: torch.Tensor) -> torch.Tensor:
        # preds: [N, S, S, B*5 + C]
        N = preds.size(0)
        device = preds.device

        # Split predictions into per-box and per-cell-class parts
        class_pred = preds[..., self.B * 5: self.B * 5 + self.C]  # [N,S,S,C]

        loss_coord = torch.tensor(0.0, device=device)
        loss_obj = torch.tensor(0.0, device=device)
        loss_noobj = torch.tensor(0.0, device=device)

        obj_any_mask = torch.zeros_like(class_pred[..., :1])  # [N,S,S,1]

        # Accumulate losses across box slots
        for b in range(self.B):
            off = b * 5
            box_pred = preds[..., off:off + 5]  # [N,S,S,5]
            box_tgt = targets[..., off:off + 5]

            obj_tgt = box_tgt[..., 4:5]  # [N,S,S,1]
            obj_pred = box_pred[..., 4:5]

            # objectness (masked per positive/negative)
            loss_obj = loss_obj + (F.binary_cross_entropy_with_logits(obj_pred, obj_tgt, reduction='none') * obj_tgt).sum()
            loss_noobj = loss_noobj + (F.binary_cross_entropy_with_logits(obj_pred, torch.zeros_like(obj_pred), reduction='none') * (1.0 - obj_tgt)).sum()

            # coordinate loss only where object exists (this slot responsible)
            coord_mask = obj_tgt  # [N,S,S,1]
            if coord_mask.sum() > 0:
                # Bound predictions to [0,1] for stability (match decoder)
                pred_xywh = torch.sigmoid(box_pred[..., 0:4])
                # SmoothL1 is more robust than MSE
                loss_coord = loss_coord + F.smooth_l1_loss(pred_xywh * coord_mask, box_tgt[..., 0:4] * coord_mask, reduction='sum')

            # track cells with any object for class loss mask
            obj_any_mask = torch.maximum(obj_any_mask, obj_tgt)

        # class loss only for cells containing at least one object
        class_tgt = targets[..., self.B * 5: self.B * 5 + self.C]
        if obj_any_mask.sum() > 0:
            loss_class = (F.binary_cross_entropy_with_logits(class_pred, class_tgt, reduction='none') * obj_any_mask).sum()
        else:
            loss_class = torch.tensor(0.0, device=device)

        # Normalize by counts to stabilize
        pos_boxes = 0.0
        neg_boxes = 0.0
        for b in range(self.B):
            off = b * 5
            obj_tgt = targets[..., off + 4: off + 5]
            pos_boxes = pos_boxes + obj_tgt.sum()
        total_slots = float(self.B * self.S * self.S * N)
        neg_boxes = max(total_slots - float(pos_boxes.item()), 1.0)

        pos_cells = obj_any_mask.sum().item() if obj_any_mask is not None else 1.0
        pos_boxes = max(float(pos_boxes.item()), 1.0)

        loss_coord = loss_coord / pos_boxes
        loss_obj = loss_obj / pos_boxes
        loss_noobj = loss_noobj / neg_boxes
        loss_class = loss_class / max(1.0, pos_cells)

        loss = self.lambda_coord * loss_coord + loss_obj + self.lambda_noobj * loss_noobj + loss_class
        return loss


def _collate_batch(batch):
    """Custom collate: stack images, keep boxes as python lists.

    batch: list of (image_tensor, boxes_list)
    returns: images [N,3,88,88], list_of_boxes (len N)
    """
    imgs = [b[0] for b in batch]
    boxes = [b[1] for b in batch]
    return torch.stack(imgs, dim=0), boxes


def evaluate(model: nn.Module, loader: DataLoader, loss_fn: nn.Module, grid_size: int, num_boxes: int, num_classes: int, device: str) -> float:
    model.eval()
    total = 0.0
    with torch.no_grad():
        for imgs, boxes_batch in loader:
            imgs = imgs.to(device)
            targets = torch.stack(
                [encode_targets(boxes, grid_size, num_boxes, num_classes) for boxes in boxes_batch],
                dim=0,
            ).to(device)
            _, preds = model(imgs)
            loss = loss_fn(preds, targets)
            total += float(loss.item())
    model.train()
    return total / max(1, len(loader))


def train(
    images_root: str,
    ann_file: str,
    val_images_root: Optional[str] = None,
    val_ann_file: Optional[str] = None,
    epochs: int = 10,
    batch_size: int = 16,
    lr: float = 1e-3,
    weight_decay: float = 1e-4,
    num_boxes: int = 2,
    num_classes: int = 1,
    grid_size: int = 4,
    device: str = None,
    out_dir: Optional[str] = None,
    max_steps: Optional[int] = None,
    amp: bool = True,
    warmup_steps: int = 500,
):
    device = device or ('cuda' if torch.cuda.is_available() else 'cpu')

    dataset = WiderFaceDataset(images_root, ann_file, img_size=88, augment=True)
    loader = DataLoader(dataset, batch_size=batch_size, shuffle=True, num_workers=4, pin_memory=True, collate_fn=_collate_batch)

    val_loader = None
    if val_images_root and val_ann_file and os.path.isdir(val_images_root) and os.path.isfile(val_ann_file):
        val_ds = WiderFaceDataset(val_images_root, val_ann_file, img_size=88, augment=False)
        val_loader = DataLoader(val_ds, batch_size=batch_size, shuffle=False, num_workers=2, pin_memory=True, collate_fn=_collate_batch)

    model = TinyissimoYOLO(num_boxes=num_boxes, num_classes=num_classes, grid_size=grid_size).to(device)
    optim = torch.optim.AdamW(model.parameters(), lr=lr, weight_decay=weight_decay)
    loss_fn = TinyYOLOLoss(S=grid_size, B=num_boxes, C=num_classes)
    # Optional LR scheduler (per-epoch cosine)
    scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optim, T_max=max(epochs,1))
    scaler = torch.cuda.amp.GradScaler(enabled=amp and (device == 'cuda'))

    if out_dir is None:
        out_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'checkpoints')
    os.makedirs(out_dir, exist_ok=True)

    best_val = float('inf')

    model.train()
    for epoch in range(1, epochs + 1):
        running_loss = 0.0
        step = 0
        total_steps = 0
        for imgs, boxes_batch in loader:
            imgs = imgs.to(device)
            batch_targets = []
            for boxes in boxes_batch:
                t = encode_targets(boxes, grid_size, num_boxes, num_classes)
                batch_targets.append(t)
            targets = torch.stack(batch_targets, dim=0).to(device)  # [N,S,S,per]

            optim.zero_grad(set_to_none=True)
            with torch.cuda.amp.autocast(enabled=scaler.is_enabled()):
                _, preds = model(imgs)
                loss = loss_fn(preds, targets)
            scaler.scale(loss).backward()
            scaler.step(optim)
            scaler.update()

            running_loss += float(loss.item())
            step += 1
            total_steps += 1

            # Warmup: linearly scale LR for first warmup_steps
            if total_steps <= warmup_steps:
                warm_lr = lr * (total_steps / max(1, warmup_steps))
                for pg in optim.param_groups:
                    pg['lr'] = warm_lr
            if max_steps is not None and step >= max_steps:
                break

        denom = min(len(loader), max_steps) if max_steps else len(loader)
        avg = running_loss / max(1, denom)

        # validation
        val_msg = ""
        if val_loader is not None:
            val_loss = evaluate(model, val_loader, loss_fn, grid_size, num_boxes, num_classes, device)
            val_msg = f", val loss: {val_loss:.4f}"
            # save best
            if val_loss < best_val:
                best_val = val_loss
                torch.save({'model': model.state_dict(), 'epoch': epoch, 'val_loss': best_val}, os.path.join(out_dir, 'best.pt'))

        # always save last
        torch.save({'model': model.state_dict(), 'epoch': epoch}, os.path.join(out_dir, 'last.pt'))
        print(f"Epoch {epoch}/{epochs} - train loss: {avg:.4f}{val_msg}")
        scheduler.step()


def parse_args():
    p = argparse.ArgumentParser()
    script_dir = os.path.dirname(os.path.abspath(__file__))
    default_images = os.path.join(script_dir, 'WIDER_train', 'images')
    default_ann = os.path.join(script_dir, 'wider_face_split', 'wider_face_train_bbx_gt.txt')
    default_val_images = os.path.join(script_dir, 'WIDER_val', 'images')
    default_val_ann = os.path.join(script_dir, 'wider_face_split', 'wider_face_val_bbx_gt.txt')

    p.add_argument('--images', default=default_images, help='Root folder for WiderFace images (train set)')
    p.add_argument('--ann', default=default_ann, help='Path to wider_face_train_bbx_gt.txt')
    p.add_argument('--val-images', default=default_val_images, help='Root folder for WiderFace val images')
    p.add_argument('--val-ann', default=default_val_ann, help='Path to wider_face_val_bbx_gt.txt')
    p.add_argument('--epochs', type=int, default=10)
    p.add_argument('--batch', type=int, default=16)
    p.add_argument('--lr', type=float, default=1e-3)
    p.add_argument('--wd', type=float, default=1e-4, help='Weight decay for AdamW')
    p.add_argument('--b', type=int, default=2, help='Number of boxes per cell')
    p.add_argument('--c', type=int, default=1, help='Number of classes')
    p.add_argument('--s', type=int, default=8, help='Grid size S')
    p.add_argument('--out', default=os.path.join(script_dir, 'checkpoints'), help='Output directory for checkpoints')
    p.add_argument('--max-steps', type=int, default=None, help='Limit training steps per epoch for quick smoke tests')
    p.add_argument('--no-amp', action='store_true', help='Disable mixed precision')
    p.add_argument('--warmup-steps', type=int, default=500, help='Linear warmup steps at start of training')
    return p.parse_args()


if __name__ == '__main__':
    args = parse_args()
    # Basic path sanity checks with helpful hints
    if not os.path.isdir(args.images):
        raise SystemExit(f"Images root not found: {args.images}\nPlease set --images to your WIDER_train/images directory.")
    if not os.path.isfile(args.ann):
        raise SystemExit(f"Annotation file not found: {args.ann}\nPlease set --ann to wider_face_train_bbx_gt.txt")
    train(
        images_root=args.images,
        ann_file=args.ann,
        val_images_root=args.val_images if os.path.isdir(args.val_images) else None,
        val_ann_file=args.val_ann if os.path.isfile(args.val_ann) else None,
        epochs=args.epochs,
        batch_size=args.batch,
        lr=args.lr,
        weight_decay=args.wd,
        num_boxes=args.b,
        num_classes=args.c,
        grid_size=args.s,
        out_dir=args.out,
        max_steps=args.max_steps,
        amp=not args.no_amp,
        warmup_steps=args.warmup_steps,
    )
