def get_aligned_characters(line_1, line_2)
    line_1.each_char.with_index.reduce([]) do |same_chars, (char, i)|
        same_chars.push(char) if line_2[i] == char
        same_chars
    end
end

File.open('../input.txt', 'r').to_a.map { |s| s.chomp }.combination(2).each do |(line_1, line_2)|
    aligned_chars = get_aligned_characters(line_1, line_2)
    next if aligned_chars.length != line_1.length - 1
    puts aligned_chars.join
end
