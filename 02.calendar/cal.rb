#!/usr/bin/env ruby
require 'date'
require 'optparse'

YEAR_MIN = 1970
YEAR_MAX = 2100
LINE_WIDTH = 20
DAY_WIDTH = 2

def main
  year, month = get_input_date
  print_calendar(year, month)
end

def get_input_date
  opt = OptionParser.new
  today = Date.today

  year = today.year
  opt.on('-y YEAR', Integer) do |input_year|
    year = input_year if input_year.between?(YEAR_MIN, YEAR_MAX)
  end

  month = today.month
  opt.on('-m MONTH', Integer) do |input_month|
    month = input_month if input_month.between?(1, 12)
  end

  opt.parse!(ARGV)
  [year, month]
end

def print_calendar(year, month)
  puts "#{month}月 #{year}".center(LINE_WIDTH)
  puts "日 月 火 水 木 金 土"

  first_date = Date.new(year, month, 1)
  last_date = Date.new(year, month, -1)
  date_text = " " * (DAY_WIDTH + 1) * first_date.wday
  today = Date.today

  (first_date..last_date).each do |date|
    date_text += "\e[47m" if date == today
    date_text += date.day.to_s.rjust(DAY_WIDTH)
    date_text += "\e[0m" if date == today

    if date.saturday? || date == last_date
      puts date_text
      date_text = ""
    else
      date_text += " "
    end
  end

  puts
end

main
