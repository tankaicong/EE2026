import csv
with open('text.mem', 'w') as txt:
    with open('text mem.csv', newline='') as fh:
        reader = csv.reader(fh)
        for row in reader:
            # row items are already split, but may still have whitespace
            items = [it.strip() for it in row if it.strip() != '']
            print(len(items))
            for item in items:
                txt.write(item + '\n')
