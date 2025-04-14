#!/usr/bin/env ruby
PRINT_START = 1
PRINT_END = 20

def fizzbuzz(number)
  if number % 15 == 0
    puts "FizzBuzz"
  elsif number % 3 == 0
    puts "Fizz"
  elsif number % 5 == 0
    puts "Buzz"
  else
    puts number
  end
end

PRINT_START.upto(PRINT_END) { |i| fizzbuzz(i) }
