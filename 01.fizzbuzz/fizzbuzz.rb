#!/usr/bin/env ruby
FizzBuzz = 15
Fizz = 3
Buzz = 5
PrintStart = 1
PrintEnd = 20

# fizzbuzz判定・出力.
def fizzbuzz(number)
  # 3と5両方の倍数.
  if number % FizzBuzz == 0
    puts "FizzBuzz"
  # 3の倍数.
  elsif number % Fizz == 0
    puts "Fizz"
  # 5の倍数.
  elsif number % Buzz == 0
    puts "Buzz"
  else
    puts number
  end
end

# PrintStartからPrintEndまでプリント.
PrintStart.upto(PrintEnd) { |i| fizzbuzz(i)}
