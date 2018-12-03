require_relative '../common/common.rb'

def contested_coords(claims)
    claims.combination(2).map { |(c1, c2)| c1.intersect(c2) }.compact.map { |c| c.all_coords }.flatten(1).uniq
end

p contested_coords(claims_from_file('../input.txt')).length
