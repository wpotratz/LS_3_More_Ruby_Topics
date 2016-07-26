require 'pry'

class House
  INTRO = 'This is'

  def self.recite
    new.build_rhyme
  end

  def build_rhyme
    rhyme = ''
    previous_phrase1 = ''
    previous_lines = ''

    pieces.reverse.each do |phrase|
      phrase1 = phrase[0].to_s
      phrase2 = phrase[1].to_s
      if phrase2.empty?
        rhyme << "#{INTRO} #{phrase1}.\n"
        previous_phrase1 = phrase1 + "."
      else
        previous_lines.prepend "#{phrase2} #{previous_phrase1}\n"
        rhyme << "\n#{INTRO} #{phrase1}\n#{previous_lines}"
        previous_phrase1 = phrase1
      end
    end

    rhyme
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

# binding.pry