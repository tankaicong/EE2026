"""
Demo inference script for TinyissimoYOLO.

Loads a trained checkpoint and runs inference on a few images, drawing
predicted bounding boxes and saving the visualizations.

Defaults point to your local WiderFace folders next to this script.
"""

from __future__ import annotations

import argparse
import os
from typing import List, Tuple

from PIL import Image, ImageDraw
import torch
import torch.nn.functional as F
from torchvision import transforms

from cnn import TinyissimoYOLO


def list_images(root: str, exts=(".jpg", ".jpeg", ".png")) -> List[str]:
    files = []
    for dp, _, fnames in os.walk(root):
        for n in fnames:
            if n.lower().endswith(exts):
                files.append(os.path.join(dp, n))
    return sorted(files)


def nms(boxes: torch.Tensor, scores: torch.Tensor, iou_thresh: float) -> List[int]:
    """Simple NMS for [N,4] boxes in xyxy format.
    Returns indices to keep sorted by score descending.
    """
    if boxes.numel() == 0:
        return []
    x1, y1, x2, y2 = boxes.t()
    areas = (x2 - x1).clamp(min=0) * (y2 - y1).clamp(min=0)
    order = scores.argsort(descending=True)
    keep = []
    while order.numel() > 0:
        i = int(order[0])
        keep.append(i)
        if order.numel() == 1:
            break
        rest = order[1:]
        xx1 = torch.max(x1[i], x1[rest])
        yy1 = torch.max(y1[i], y1[rest])
        xx2 = torch.min(x2[i], x2[rest])
        yy2 = torch.min(y2[i], y2[rest])
        w = (xx2 - xx1).clamp(min=0)
        h = (yy2 - yy1).clamp(min=0)
        inter = w * h
        iou = inter / (areas[i] + areas[rest] - inter + 1e-6)
        order = rest[iou <= iou_thresh]
    return keep


def decode_outputs(grid: torch.Tensor, S: int, B: int, C: int, img_w: int, img_h: int, conf_thresh: float) -> Tuple[torch.Tensor, torch.Tensor, torch.Tensor]:
    """Decode model grid output [S,S,(B*5+C)] into boxes for a single image.

    Returns (boxes_xyxy, scores, classes)
    boxes are in pixel coordinates for original image size.
    """
    grid = grid.detach().cpu()
    per_cell = B * 5 + C
    assert grid.shape == (S, S, per_cell)

    boxes = []
    scores = []
    classes = []
    for j in range(S):  # y (row)
        for i in range(S):  # x (col)
            cell = grid[j, i]
            class_logits = cell[B * 5 : B * 5 + C]
            class_probs = torch.sigmoid(class_logits)
            for b in range(B):
                off = b * 5
                tx, ty, tw, th, tobj = cell[off: off+5]
                obj = torch.sigmoid(tobj)
                if obj.item() < conf_thresh:
                    continue
                # offsets in [0,1]
                ox = torch.sigmoid(tx)
                oy = torch.sigmoid(ty)
                ww = torch.sigmoid(tw)
                hh = torch.sigmoid(th)
                cx = (i + ox.item()) / S
                cy = (j + oy.item()) / S
                w = ww.item()
                h = hh.item()
                # class selection
                if C > 0:
                    cprob, cidx = torch.max(class_probs, dim=0)
                    score = obj.item() * cprob.item()
                    cls = int(cidx.item())
                else:
                    score = obj.item()
                    cls = 0
                # convert to xyxy pixels
                x1 = max(0.0, (cx - w / 2.0) * img_w)
                y1 = max(0.0, (cy - h / 2.0) * img_h)
                x2 = min(float(img_w), (cx + w / 2.0) * img_w)
                y2 = min(float(img_h), (cy + h / 2.0) * img_h)
                boxes.append([x1, y1, x2, y2])
                scores.append(score)
                classes.append(cls)

    if len(boxes) == 0:
        return torch.zeros((0,4)), torch.zeros((0,)), torch.zeros((0,), dtype=torch.long)
    return torch.tensor(boxes, dtype=torch.float32), torch.tensor(scores, dtype=torch.float32), torch.tensor(classes, dtype=torch.long)


def draw_boxes(img: Image.Image, boxes: torch.Tensor, scores: torch.Tensor, color=(255, 0, 0)) -> Image.Image:
    draw = ImageDraw.Draw(img)
    for (x1, y1, x2, y2), s in zip(boxes.tolist(), scores.tolist()):
        draw.rectangle([x1, y1, x2, y2], outline=color, width=2)
        draw.text((x1, max(0, y1 - 10)), f"{s:.2f}", fill=color)
    return img


def main():
    ap = argparse.ArgumentParser()
    script_dir = os.path.dirname(os.path.abspath(__file__))
    ap.add_argument('--weights', default=os.path.join(script_dir, 'checkpoints', 'best.pt'), help='Path to checkpoint .pt (best.pt or last.pt)')
    ap.add_argument('--images', default=os.path.join(script_dir, 'WIDER_val', 'images'), help='Folder with test/val images (recursively scanned)')
    ap.add_argument('--out', default=os.path.join(script_dir, 'demos'), help='Output folder for annotated images')
    ap.add_argument('--num', type=int, default=8, help='Number of demo images')
    ap.add_argument('--s', type=int, default=8, help='Grid size S used by the model')
    ap.add_argument('--b', type=int, default=2, help='Number of boxes per cell B')
    ap.add_argument('--c', type=int, default=1, help='Number of classes C')
    ap.add_argument('--conf', type=float, default=0.5, help='Confidence threshold')
    ap.add_argument('--nms', type=float, default=0.4, help='NMS IoU threshold')
    args = ap.parse_args()

    device = 'cuda' if torch.cuda.is_available() else 'cpu'

    # Model
    model = TinyissimoYOLO(num_boxes=args.b, num_classes=args.c, grid_size=args.s).to(device)
    if os.path.isfile(args.weights):
        ckpt = torch.load(args.weights, map_location=device)
        state = ckpt.get('model', ckpt)
        model.load_state_dict(state, strict=False)
    else:
        print(f"Warning: weights not found at {args.weights}, using random weights.")
    model.eval()

    tfm = transforms.Compose([transforms.Resize((88, 88)), transforms.ToTensor()])

    os.makedirs(args.out, exist_ok=True)
    images = list_images(args.images)
    if len(images) == 0:
        raise SystemExit(f"No images found under: {args.images}")
    images = images[: args.num]

    for p in images:
        img = Image.open(p).convert('RGB')
        w0, h0 = img.size
        x = tfm(img).unsqueeze(0).to(device)
        with torch.no_grad():
            _, grid = model(x)  # [1,S,S,per]
        boxes, scores, classes = decode_outputs(grid[0], args.s, args.b, args.c, w0, h0, args.conf)
        if len(boxes) > 0 and args.nms > 0:
            keep = nms(boxes, scores, args.nms)
            boxes = boxes[keep]
            scores = scores[keep]

        vis = img.copy()
        vis = draw_boxes(vis, boxes, scores)
        out_path = os.path.join(args.out, os.path.basename(p))
        vis.save(out_path)
        print(f"Saved: {out_path} with {len(boxes)} boxes")


if __name__ == '__main__':
    main()
