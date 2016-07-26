# trinary.rb
require 'pry'

class Trinary
  def initialize(numeric_string)
    @trinary_number = validate_string(numeric_string)
  end
  
  def to_decimal
    return 0 if @trinary_number.nil?

    reverse_number_str.each_with_index.reduce(0) do |decimal, (value, i)|
      decimal + value.to_i*3**i
    end
  end

  private

  def reverse_number_str
    @trinary_number.reverse.each_char
  end
  
  def validate_string(numeric_string)
    numeric_string unless /[^012]/.match(numeric_string)
  end
end