"""texttocsv.py

Read a text file and write a CSV where each input character becomes a CSV field.
Spaces are replaced with the literal string (space).

Usage:
  python texttocsv.py -i text.txt -o out.csv

Options:
  -i --input    input text file (default: text.txt)
  -o --output   output csv file (default: out.csv)
  --replace     replacement for space characters (default: (space))
  --strip-end   strip common ending punctuation from lines (.,;:!?)
"""
import argparse
import csv
import os
import sys


def convert_file(input_path, output_path, replace_space='(space)', strip_end=False):
	if not os.path.exists(input_path):
		raise FileNotFoundError(f'Input file not found: {input_path}')

	end_chars = ''

	with open(input_path, 'r', encoding='utf-8') as fin, \
		 open(output_path, 'w', newline='', encoding='utf-8') as fout:
		writer = csv.writer(fout)
		for raw_line in fin:
			# remove trailing newline/carriage returns only
			line = raw_line.rstrip('\r\n')
			if strip_end:
				line = line.rstrip(end_chars)

			# If the line is empty after stripping, write an empty row
			if line == '':
				writer.writerow([])
				continue

			row = []
			for ch in line:
				if ch == ' ':
					row.append(replace_space)
				else:
					row.append(ch)

			writer.writerow(row)


def main(argv=None):
	p = argparse.ArgumentParser(description='Convert text to per-character CSV (spaces -> (space))')
	p.add_argument('-i', '--input', default='text.txt', help='Input text file')
	p.add_argument('-o', '--output', default='out.csv', help='Output CSV file')
	p.add_argument('--replace', default='(space)', help='Replacement string for space characters')
	p.add_argument('--strip-end', action='store_true', help='Strip common ending punctuation from lines')
	args = p.parse_args(argv)

	try:
		convert_file(args.input, args.output, replace_space=args.replace, strip_end=args.strip_end)
	except Exception as e:
		print('Error:', e, file=sys.stderr)
		return 2

	return 0


if __name__ == '__main__':
	raise SystemExit(main())

