with open('../input.txt', 'r') as f:
    print(sum([int(x) for x in f.read().split()]))
