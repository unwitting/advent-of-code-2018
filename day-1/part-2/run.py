seen_frequencies = [0]

with open('../input.txt', 'r') as f:
    frequency_deltas = [int(x) for x in f.read().split()]

frequency = seen_frequencies[0]
i = 0
while True:
    delta = frequency_deltas[i]
    frequency += delta
    if frequency in seen_frequencies:
        break
    seen_frequencies.append(frequency)
    i = (i + 1) % len(frequency_deltas)

print(frequency)
