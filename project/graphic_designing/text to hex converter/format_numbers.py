"""format_numbers.py

Paste your input numbers into the INPUT string below. The script will
parse integers (split on commas or any whitespace) and print them
joined by a comma + space, e.g.:

Input: 4\t26\t28\t33\t52\t48 ...
Output: 4, 26, 28, 33, 52, 48, ...

Usage:
  - Edit the INPUT variable in this file, save, then run:
      python format_numbers.py

Optional: set LIMIT to an integer to truncate the output to the first N numbers.
"""

import re

# Paste your input here (the script will parse numbers separated by commas, tabs, or spaces)
INPUT = """
4	26	28	33	52	48	33	34	45	30	52	41	34	49	30	37	57	53	58	52	34	44	52	26	52	39	40	29	30
"""

INPUT1 = """
34	13	52	0	52	6	17	8	3	55	52	13	4	8	6	7	1	14	20	17	18	52	5	14	17	12
"""

# If you want only the first N numbers, set LIMIT to an int (or None to print all)
LIMIT = None


def parse_and_format(s: str, limit: int | None = None) -> str:
    """Return a string of integers from s joined by ", ".

    - Splits on commas or any whitespace.
    - Keeps only signed integer tokens (e.g. -12, +3, 42).
    - Supports optional LIMIT to return only the first N numbers.
    """
    tokens = [t for t in re.split(r"[,\s]+", s.strip()) if t != ""]
    nums = []
    for t in tokens:
        if re.fullmatch(r"[+-]?\d+", t):
            nums.append(str(int(t)))
        else:
            # ignore non-integer tokens
            continue

    if limit is not None:
        nums = nums[:limit]

    return ", ".join(nums)


if __name__ == "__main__":
    out = parse_and_format(INPUT, limit=LIMIT)
    print(out)
    out1 = parse_and_format(INPUT1, limit=LIMIT)
    print(out1)
