#!/usr/bin/env ruby
PATH = './inputs/day_06.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class PacktSniffr
  def initialize(num)
    @count = 0
    @last_chars = []
    @num = num
  end

  def run
    process_input
    report
  end

  def process_input
    INPUT.first.chars do |char|
      @count += 1
      @last_chars << char
      @last_chars.shift if @last_chars.size > @num
      break if @last_chars.uniq.size == @num
    end
  end

  def report
    puts @count
  end
end

puts '--- Day 6: Tuning Trouble ---'
puts '--- Part 1 ---'
ps4 = PacktSniffr.new(4)
ps4.run

puts '--- Part 2 ---'
ps14 = PacktSniffr.new(14)
ps14.run
