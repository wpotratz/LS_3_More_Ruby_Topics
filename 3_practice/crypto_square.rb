require 'pry'

class Crypto
  def initialize(phrase)
    @clean_plaintext = phrase.downcase.gsub(/[^[:alnum:]]/, '')
  end

  def size
    Math.sqrt(normalize_plaintext.size).ceil
  end

  def plaintext_segments
    segments.map { |string| string.join }
  end

  def ciphertext
    ciphertext_segments.join
  end

  def normalize_plaintext
    @clean_plaintext
  end

  def normalize_ciphertext
    ciphertext_segments.join(' ')
  end

  private

  def segments
    raw_segments = normalize_plaintext.chars.each_slice(size).to_a
    last_segment = raw_segments.last
    last_segment << '' until last_segment.size == size

    raw_segments
  end

  def ciphertext_segments
    segments.transpose.map { |string| string.join }
  end
end
