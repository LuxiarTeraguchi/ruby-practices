#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN_MAX = 3
WIDTH_UNIT = 8

def main
  filenames = list_filenames
  rows = make_rows(filenames)
  output_rows(rows)
end

def list_filenames
  opt = OptionParser.new
  filenames = Dir.glob('*').map { |path| File.basename(path) }
  opt.on('-a') { filenames = Dir.entries('.') }
  opt.parse!(ARGV)
  filenames.sort_by(&:downcase)
end

def make_rows(filenames)
  rows_size = (filenames.size + COLUMN_MAX - 1) / COLUMN_MAX
  column_width = ((filenames.map(&:size).max + WIDTH_UNIT) / WIDTH_UNIT) * WIDTH_UNIT
  rows = []
  filenames.each_with_index do |filename, index|
    rows_index = index % rows_size
    rows[rows_index] ||= []
    rows[rows_index] << filename.ljust(column_width)
  end
  rows
end

def output_rows(rows)
  rows.each do |row|
    puts row.join.rstrip
  end
end

main
