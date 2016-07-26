require 'pry'

class Phrase
  def initialize(string)
    @phrase = string
  end

  def word_count
    collection = Hash.new(0)
    clean(@phrase).split(' ').each do |word|
      collection[word] += 1
    end
    collection
  end

  def clean (phrase)
    phrase = phrase.downcase
    phrase.gsub!(/[^[[:alnum:]][[:space:]]']|(\s')|('\s)/, ' ')
    phrase.squeeze(' ').strip.downcase
  end
end