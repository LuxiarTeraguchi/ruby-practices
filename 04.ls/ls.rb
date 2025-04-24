#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN_MAX = 3
WIDTH_UNIT = 8

def main
  options = parse_options
  filenames = list_filenames(options)
  rows = make_rows(filenames)
  output_rows(rows)
end

def parse_options
  opt = OptionParser.new
  options = {}
  opt.on('-a') { options[:a] = true }
  opt.on('-r') { options[:r] = true }
  opt.parse!(ARGV)
  options
end

def list_filenames(options)
  filenames = Dir.glob('*')
  filenames = Dir.entries('.') if options[:a]
  filenames = filenames.sort_by(&:downcase)
  options[:r] ? filenames.reverse : filenames
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
