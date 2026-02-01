import csv
with open('new BRAM IP block/new_letters.coe', 'w') as coe:
    with open('all.csv', newline='') as fh:
        coe.write('memory_initialization_radix=16;\n'
                  'memory_initialization_vector=\n')
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

# with open('letters.coe', 'a') as coe:
# count = 0
# with open('red_R.csv', 'r') as csv:
#     lines = csv.readlines()
#     print(len(lines))
#     for line in lines:
#         splitted = line.split(',')
#         print(len(splitted))
#         for item in splitted:
#             if (item == '2'):
#                 count += 1
#                 # print('00F,')
#             if (item == '1'):
#                 count += 1
#                 # print('FFF,')
# print(count)

# import csv

# count = 0
# with open('red_R.csv', newline='') as fh:
#     reader = csv.reader(fh)
#     for row in reader:
#         # row items are already split, but may still have whitespace
#         items = [it.strip() for it in row if it.strip() != '']
#         print(len(items))
#         for item in items:
#             if item == '1':
#                 print('1')
#             if item == '2':
#                 print('2')

# print(count)  # should be 144