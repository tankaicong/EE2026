import csv
with open('letters.mem', 'w') as coe:
    with open('all.csv', newline='') as fh:
        reader = csv.reader(fh)
        for row in reader:
            # row items are already split, but may still have whitespace
            items = [it.strip() for it in row if it.strip() != '']
            print(len(items))
            for item in items:
                write = item
                if item == '10': write = 'A'
                if item == '11': write = 'B'
                if item == '12': write = 'C'
                if item == '13': write = 'D'
                if item == '14': write = 'E'
                if item == '15': write = 'F'
                coe.write(write + '\n')
