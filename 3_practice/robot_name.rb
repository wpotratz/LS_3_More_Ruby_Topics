class Robot
  @names = []

  NAME_FIRST_TWO_CHARS = [*'A'..'Z']
  NAME_LAST_THREE_CHARS = [*'0'..'9']

  attr_reader :name

  def self.names
    @names
  end

  def initialize
    assign_name
  end

  def reset
    assign_name
  end

  private

  def assign_name
    new_name = generate_unique_name
    Robot.names.delete(@name) if @name

    @name = new_name
    Robot.names << new_name
  end

  def generate_unique_name
    name_candidate = ''
    while name_candidate.empty? || name_taken?(name_candidate)
      name_candidate.clear
      2.times { name_candidate << NAME_FIRST_TWO_CHARS.sample }
      3.times { name_candidate << NAME_LAST_THREE_CHARS.sample }
    end

    name_candidate
  end

  def name_taken?(this_name)
    Robot.names.include? this_name
  end
end
