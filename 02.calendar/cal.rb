#!/usr/bin/env ruby
require 'date'
require 'optparse'

# 定数.
YearMin = 1700
YearMax = 2100
January = 1
December = 12
LineWidth = 20
DayWidth = 2

# コマンドライン引数から指定月の月初め・月末を取得.
def get_input_date
  opt = OptionParser.new
  today = Date.today
  year = today.year
  month = today.month

  # -yオプションでの年指定.
  opt.on('-y YEAR', Integer) do |input_year|
    # 範囲外の年は弾く.
    if input_year.between?(YearMin, YearMax)
      year = input_year
    else
      puts "year '#{input_year}' not in range #{YearMin}..#{YearMax}"
      exit
    end
  end

  # -mオプションでの月指定.
  opt.on('-m MONTH', Integer) do |input_month|
    # 存在しない月は弾く.
    if input_month.between?(January, December)
      month = input_month
    else
      puts "#{input_month} is neither a month number (#{January}..#{December}) nor a name"
      exit
    end
  end

  opt.parse!(ARGV)
  return year, month
end

# カレンダー出力.
def print_calendar(year:, month:)
  today = Date.today # 今日.
  date_first = Date.new(year, month, 1) # 指定年月の月初め.
  date_last = Date.new(year, month, -1) # 指定年月の月末.
  date_text = ""

  puts "#{month}月 #{year}".center(LineWidth) # 月・年出力. 中央揃え.
  puts "日 月 火 水 木 金 土" # 曜日出力.

  # 日付出力.
  (date_first..date_last).each do |date|
    # 日付追加. 今日なら背景色を変える.
    date_text += "\e[47m" if date == today
    date_text += date.day.to_s.rjust(DayWidth) # 幅を合わせる.
    date_text += "\e[0m" if date == today

    # 行末まで来たら出力.
    # 土曜なら右揃えで出力.
    if date.wday == 6
      puts date_text.rjust(LineWidth) + "\n"
      date_text = ""
    # 月末ならそのまま出力.
    elsif date == date_last
      puts date_text + "\n"
    # 行末でないなら余白追加.
    else
      date_text += " "
    end
  end

  puts "\n"
end

year, month = get_input_date() # 指定年月取得.
print_calendar(year: year, month: month) # カレンダー出力.
