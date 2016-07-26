# meetup.rb
require 'pry'
require 'date'

class Meetup
  attr_reader :month, :year, :start_day

  def initialize(month_num, year)
    @month = month_num
    @year = year
    @start_day = {
      first: 1,
      second: 8,
      third: 15,
      fourth: 22,
      teenth: 13,
      last: last_day - 6
    }
  end

  def day(weekday, schedule)
    range = (start_day[schedule]..start_day[schedule] + 6)

    valid_day = range.find do |day|
      date = Date.new(year, month, day)
      date if date.public_send(weekday.to_s + '?')
    end

    Date.new(year, month, valid_day)
  end

  private

  def last_day
    [31, 30, 29, 28].find { |this_day| Date.valid_date?(year, month, this_day) }
  end
end
