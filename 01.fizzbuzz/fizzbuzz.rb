#!/usr/bin/env ruby

# fizzbuzz判定・出力.
def fizzbuzz(number)
  # 3と5両方の倍数.
  if number % 15 == 0
    puts "FizzBuzz"
  # 5の倍数.
  elsif number % 5 == 0
    puts "Buzz"
  # 3の倍数.
  elsif number % 3 == 0
    puts "Fizz"
  else
    puts number
  end
end

# 1から20までプリント.
1.upto(20) { |i| fizzbuzz(i)}
