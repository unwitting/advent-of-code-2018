Claim = Struct.new(:id, :x, :y, :w, :h) do
    def all_coords
        (x..(x + w - 1)).to_a.product((y..(y + h - 1)).to_a)
    end

    def intersect(other)
        claim_from_coords(all_coords & other.all_coords)
    end
end

def claim_from_coords(coords)
    return if coords.empty?
    min_x = coords.map { |(x, y)| x }.min
    max_x = coords.map { |(x, y)| x }.max
    min_y = coords.map { |(x, y)| y }.min
    max_y = coords.map { |(x, y)| y }.max
    Claim.new(nil, min_x, min_y, 1 + max_x - min_x, 1 + max_y - min_y)
end

def claim_from_raw(line)
    Claim.new(*(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/.match(line).captures.map { |x| x.to_i }))
end

def claims_from_file(path)
    File.open(path, 'r').each_line.map { |s| claim_from_raw(s.chomp) }
end