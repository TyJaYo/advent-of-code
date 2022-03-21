#!/usr/bin/env ruby
puts "--- Day 9: Encoding Error ---"
puts "--- Part 0: Parse Input ---"
PATH = './inputs/day-09.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).map(&:to_i).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts "--- Part 1: Find Combo Breaker ---"
class Crawler
  attr_accessor :bloc
  def initialize
    @range = 25
    @found = false
  end
  def check(pos)
    bmin = pos - @range
    val = INPUT[pos]
    bloc = INPUT[bmin...pos]

    bloc.each do |b|
      next if b >= val
      bloc.each do |c|
        next if c == b
        return if c + b == val
      end
    end
    puts "No pair found in preceding #{@range} for #{val}."
    @found = val
  end
  def crawl
    for pos in @range...INPUT.size
      check(pos)
      break if @found
    end
  end
end

part_one = Crawler.new

puts "Find the first number in the list which is not the sum of two of the 25 numbers before it."
puts "What is the first number that does not have this property?"
part_one.crawl

puts "--- Part 2: Find contiguous nums that sum to part 1 ---"
part_two = Crawler.new

puts "What is the encryption weakness in your XMAS-encrypted list of numbers?"
# puts part_two.switch_fix
