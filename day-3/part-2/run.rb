require_relative '../common/common.rb'

def uncontested_claims(claims)
    claims.keep_if do |c|
        p c
        without_c = claims.select { |other| other != c }
        without_c.take_while { |other| c.intersect(other).nil? }.length == without_c.length
    end
end

p uncontested_claims(claims_from_file('../input.txt')).first.id
