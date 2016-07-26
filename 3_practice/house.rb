require 'pry'

class House
  INTRO = 'This is '
  ENDING = '.'
  def self.recite
    new.build_rhyme
  end

  def build_rhyme
    rhyme = []
    (-pieces.size..-1).each do |i|
      paragraph = pieces[i..-1].map { |chunk| chunk.join("\n") }.join(" ")
      rhyme << INTRO + paragraph + ENDING
    end
    
    rhyme.reverse.join("\n\n") + "\n"
  end

  private

  def pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end

#House.recite