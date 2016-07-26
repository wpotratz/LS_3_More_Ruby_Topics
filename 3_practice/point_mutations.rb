require 'pry'

class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(compare_strand)
    compare_strands = [@strand.chars, compare_strand.chars].sort { |strand1, strand2| strand1.size <=> strand2.size }
    compare_strands[0].zip(compare_strands[1]).reduce(0) do |distance, (char1, char2)|
      char1 != char2 ? distance + 1 : distance
    end
    #'AAACTAGGGG'
    #'AGGCTAGCGG'TAGGAC'
    #compare_strand.each_char.with_index.reduce(0) do |distance, (char, i)|
    #  if char != @strand[i] && !@strand[i].nil?
    #    distance + 1
    #  else
    #    distance
    #  end
    #end
    
    #distance = 0
    #compare_strand.each_char.with_index do |char, i|
    #  distance += 1 if @strand[i] != char && !@strand[i].nil?
    #end
    #
    #distance
  end
end
