# clock.rb
require 'pry'

class Clock
  MINUTES = (0..59)
  HOURS = (0..23)

  def self.at(hour, minute = 0)
    new(hour, minute)
  end

  def ==(other)
    to_s == other.to_s
  end

  def initialize(hours, minutes)
    @minutes = MINUTES.to_a
    @hours = HOURS.to_a
    self.minutes = minutes
    self.hours = hours
  end

  def to_s
    "#{format_number(hours)}:#{format_number(minutes)}"
  end

  def minutes
    @minutes[0]
  end

  def hours
    @hours[0]
  end

  def minutes=(new_minute)
    unless MINUTES.to_a.include?(new_minute)
      return "That's not a valid input for minutes."
    end

    @minutes.rotate! until minutes == new_minute
  end

  def hours=(new_hour)
    unless HOURS.to_a.include?(new_hour)
      return "That's not a valid input for hours."
    end

    @hours.rotate! until hours == new_hour
  end

  def turn_forward(options)
    case options[:time]
    when :hour
      @hours.rotate!
    when :minute
      @hours.rotate! if @minutes.rotate!.first == 0
    end
  end

  def turn_backward(options)
    case options[:time]
    when :hour
      @hours.rotate!(-1)
    when :minute
      @hours.rotate!(-1) if @minutes.rotate!(-1).first == 59
    end
  end

  def update_time(added_minutes)
    #binding.pry
    add_min = added_minutes.abs % 60
    add_hour = added_minutes.abs / 60

    if added_minutes == added_minutes.abs
      add_min.times { turn_forward time: :minute }
      add_hour.times { turn_forward time: :hour }
    else
      add_min.times { turn_backward time: :minute }
      add_hour.times { turn_backward time: :hour }
    end
  end

  def +(added_minutes)
    update_time(added_minutes)

    self
  end

  def -(subtracted_minutes)
    update_time(-subtracted_minutes)

    self
  end

  private

  def format_number(number)
    number.to_s.rjust(2, '0')
  end
end
