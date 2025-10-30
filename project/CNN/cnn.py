"""
TinyissimoYOLO: a very small YOLO-like model designed for extremely constrained
hardware. This PyTorch implementation follows the spec provided by the user:

Blocks (each followed by MaxPool(2,2, stride=2)):
  1) ReLU-Conv2d: 3->16 (3x3), ReLU-Conv2d: 16->16 (3x3)
  2) ReLU-Conv2d: 16->16 (3x3), ReLU-Conv2d: 16->32 (3x3)
  3) ReLU-Conv2d: 32->32 (3x3), ReLU-Conv2d: 32->64 (3x3)
  4) ReLU-Conv2d: 64->64 (3x3), ReLU-Conv2d: 64->64 (3x3)
  5) ReLU-Conv2d: 64->128 (3x3), ReLU-Conv2d: 128->128 (3x3)

Then a fully connected layer to 256, and a detection head that maps to a
4x4 grid with either (B=2, C=1) or (B=1, C=3) as examples. The head is
parameterized by num_boxes (B), num_classes (C), and grid_size (S, default 4).

Input resolution assumed by the original diagram: 88x88. With SAME padding on
3x3 convs and 5 MaxPool(2x2, stride=2), the feature map sizes go:
  88 -> 44 -> 22 -> 11 -> 5 -> 2 (HxW)
So the last feature map is [N, 128, 2, 2].

Author: Tinyissimo implementation for experimentation on faces dataset.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Tuple

import torch
import torch.nn as nn
import torch.nn.functional as F


def _conv(in_c: int, out_c: int) -> nn.Sequential:
	"""Helper to build a Conv(3x3, padding=1) + ReLU block.

	We avoid BatchNorm to keep the model tiny for edge hardware.
	"""
	return nn.Sequential(
		nn.Conv2d(in_c, out_c, kernel_size=3, padding=1, bias=True),
		nn.ReLU(inplace=True),
	)


class TinyissimoYOLO(nn.Module):
	"""A minimal YOLO-style network for highly constrained devices.

	Parameters
	-----------
	num_boxes: int
		Number of anchor-free boxes predicted per grid cell (B).
	num_classes: int
		Number of classes (C). For a face dataset, C=1 is typical.
	grid_size: int
		Output grid size (S). The reference design uses S=4.
	in_channels: int
		Input channels, default 3 (RGB).
	input_resolution: Tuple[int, int]
		Used only for sanity checks and shape hints; network itself is fully
		convolutional up to the FC head. Default (88, 88).
	"""

	def __init__(
		self,
		num_boxes: int = 2,
		num_classes: int = 1,
		grid_size: int = 4,
		in_channels: int = 3,
		input_resolution: Tuple[int, int] = (88, 88),
	) -> None:
		super().__init__()

		self.num_boxes = num_boxes
		self.num_classes = num_classes
		self.grid_size = grid_size
		self.input_resolution = input_resolution

		# Specified conv blocks
		self.block1 = nn.Sequential(
			_conv(in_channels, 16),  # 3 -> 16
			_conv(16, 16),           # 16 -> 16
			nn.MaxPool2d(kernel_size=2, stride=2),
		)

		self.block2 = nn.Sequential(
			_conv(16, 16),           # 16 -> 16
			_conv(16, 32),           # 16 -> 32
			nn.MaxPool2d(kernel_size=2, stride=2),
		)

		self.block3 = nn.Sequential(
			_conv(32, 32),           # 32 -> 32
			_conv(32, 64),           # 32 -> 64
			nn.MaxPool2d(kernel_size=2, stride=2),
		)

		self.block4 = nn.Sequential(
			_conv(64, 64),           # 64 -> 64
			_conv(64, 64),           # 64 -> 64
			nn.MaxPool2d(kernel_size=2, stride=2),
		)

		self.block5 = nn.Sequential(
			_conv(64, 128),          # 64 -> 128
			_conv(128, 128),         # 128 -> 128
			nn.MaxPool2d(kernel_size=2, stride=2),
		)

		# After five pools, with 88x88 input we get 2x2 spatial at 128 ch
		self.feature_channels = 128
		self.feature_hw = (2, 2)  # expected H, W for 88x88 input
		flattened = self.feature_channels * self.feature_hw[0] * self.feature_hw[1]

		self.fc = nn.Sequential(
			nn.Flatten(),
			nn.Linear(flattened, 256),
			nn.ReLU(inplace=True),
		)

		head_out = grid_size * grid_size * (num_boxes * 5 + num_classes)
		self.head = nn.Linear(256, head_out)

		self._init_weights()

	def _init_weights(self) -> None:
		for m in self.modules():
			if isinstance(m, nn.Conv2d):
				nn.init.kaiming_normal_(m.weight, mode="fan_out", nonlinearity="relu")
				if m.bias is not None:
					nn.init.zeros_(m.bias)
			elif isinstance(m, nn.Linear):
				nn.init.xavier_uniform_(m.weight)
				if m.bias is not None:
					nn.init.zeros_(m.bias)

	def forward(self, x: torch.Tensor) -> Tuple[torch.Tensor, torch.Tensor]:
		"""Forward pass.

		Returns
		--------
		logits_flat: [N, S*S*(B*5 + C)]
			Raw output vector per sample.
		logits_grid: [N, S, S, (B*5 + C)]
			Reshaped grid-style output.
		"""
		n = x.size(0)

		x = self.block1(x)
		x = self.block2(x)
		x = self.block3(x)
		x = self.block4(x)
		x = self.block5(x)

		x = self.fc(x)
		logits_flat = self.head(x)

		S = self.grid_size
		per_cell = self.num_boxes * 5 + self.num_classes
		logits_grid = logits_flat.view(n, S, S, per_cell)
		return logits_flat, logits_grid


def _shape_check() -> None:
	"""Run a quick shape check on a dummy input.

	For the two suggested configurations:
	  - B=2, C=1 (common for face dataset)
	  - B=1, C=3 (alternative illustrated)
	"""
	device = "cuda" if torch.cuda.is_available() else "cpu"
	dummy = torch.randn(1, 3, 88, 88, device=device)

	for (b, c) in [(2, 1), (1, 3)]:
		model = TinyissimoYOLO(num_boxes=b, num_classes=c).to(device)
		flat, grid = model(dummy)
		print(f"Config B={b}, C={c} -> flat: {tuple(flat.shape)}, grid: {tuple(grid.shape)}")


if __name__ == "__main__":
	_shape_check()

