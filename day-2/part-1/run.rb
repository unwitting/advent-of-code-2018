Checksummer = Struct.new(:twos, :threes) do
    def checksum
        twos * threes
    end
end

def checksummer_from_char_counts(counts)
    counts.each_value.reduce(Checksummer.new(0, 0)) do |checksummer, count|
        checksummer.twos += 1 if count == 2
        checksummer.threes += 1 if count == 3
        checksummer
    end
end

def count_chars(line)
    line.each_char.reduce(Hash.new(0)) { |counts, c| counts.tap { |x| x[c] += 1 } }
end

def count_twos_and_threes_in_line(line)
    checksummer_from_char_counts(count_chars(line))
end

file_checksummer = File.open('../input.txt', 'r').each_line.reduce(Checksummer.new(0, 0)) do |checksummer, line|
    line_counts = count_twos_and_threes_in_line(line)
    checksummer.twos += 1 if line_counts.twos > 0
    checksummer.threes += 1 if line_counts.threes > 0
    checksummer
end

puts file_checksummer.checksum