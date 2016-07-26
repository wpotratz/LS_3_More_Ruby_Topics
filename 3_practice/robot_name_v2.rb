require 'pry'

class Robot
  @@robots = []
  @@robot_ids = []
  @@robot_name_idx = { 0 => {}, 1 => {}, 2 => {}, 3 => {}, 4 => {} }
  
  NAME_FIRST_TWO_CHARS = [*'A'..'Z']
  NAME_LAST_THREE_CHARS = [*'0'..'9']
  
  attr_reader :name
  
  def self.robots
    @@robots
  end

  def self.robot_ids
    @@robot_ids
  end

  def self.robot_name_idx
    @@robot_name_idx
  end
  
  def self.test_10k_robots
    start_time = Time.now
    10000.times { Robot.new }
    Time.now - start_time
  end

  def initialize
    @@robots << self
    @@robot_ids << self.object_id
    reset
  end
  
  def reset
    assign_name
  end
  
  private

  def generate_name
    name_candidate = ''
    until name_candidate.size == 5 && name_available?(name_candidate)
      name_candidate = ''
      2.times { name_candidate << NAME_FIRST_TWO_CHARS.sample }
      3.times { name_candidate << NAME_LAST_THREE_CHARS.sample }
    end
    
    name_candidate
  end

  def assign_name
    new_name = generate_name
    
    if new_name
      delete_old_name_index
      @name = new_name
      add_to_index(new_name)
      #puts "Name set to #{@name}"
    else
      puts "Error assigning name!"
    end
  end
  
  #{0 => {'V'=>[01234, 12345]}, 1 => {'L'=>[01234]}, 2 => {}, 3 => {}, 4 => {}}
  def delete_old_name_index
    Robot.robot_name_idx.each_pair do |idx, char_indexes|
      char_indexes.each_value { |object_ids| object_ids.delete(object_id) }
      char_indexes.delete_if { |_, object_ids| object_ids.empty? }
    end
  end

  def add_to_index(name)
    name.chars.each_with_index do |char, i|
      idx_loc = @@robot_name_idx[i]
      if idx_loc[char]
        idx_loc[char] << object_id
      else
        idx_loc[char] = [object_id]
      end
    end
  end
  
  def name_available?(this_name)
    name_idx_ids = this_name.each_char.with_index.map do |char, i|
      @@robot_name_idx[i][char] || []
    end
    
    for oid in @@robot_ids
      return nil if name_idx_ids.all? { |char_idx| char_idx.include?(oid) }
    end
    
    true
  end

  # def name_available_v2?(this_name)
  #   Robot.robots.select { |robot| robot.name == this_name }.empty?
  # end
end

puts Robot.test_10k_robots
#binding.pry

# {
#   0 => {
#     'A' => [5, 10, 14],
#     'B' => [1, 22, 100]
#   },
#   1 => {
#     'A' => [5, 10, 14],
#     'B' => [1, 22, 100]
#   },
#   2 => {
#     '0' => [5, 10, 14]
#   },
#   3 => {
#     '1' => [5, 10, 14]
#   },
#   4 => {
#     '2' => [5, 10, 14]
#   }
# }
