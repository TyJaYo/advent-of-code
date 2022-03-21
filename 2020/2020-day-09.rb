#!/usr/bin/env ruby
puts "--- Day 9: Encoding Error ---"
puts "--- Part 0: Parse Input ---"
PATH = './inputs/day-09.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).map(&:to_i).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts "--- Part 1: Find combo breaker ---"
class Crawler
  attr_accessor :bloc
  def initialize
    @range = 25
    @found = false
    @scopemin = 0
    @scopemax = 1
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
    @found = val
  end

  def crawl
    for pos in @range...INPUT.size
      check(pos)
      break if @found
    end
    @found
  end

  def check_scope_sum(num)
    scope = INPUT[@scopemin..@scopemax]
    sum = scope.sum
    case sum <=> num
    when -1 then @scopemax += 1
    when 0 then @found = scope.min + scope.max
    when 1 then @scopemin += 1
    end
  end

  def scan_for(num)
    @found = false
    until @found
      check_scope_sum(num)
    end
    return @found
  end
end

crwlr = Crawler.new

puts "Find the first number in the list which is not the sum of two of the 25 numbers before it."
puts "What is the first number that does not have this property?"
puts ans_one = crwlr.crawl

puts "--- Part 2: Find contiguous nums that sum to part 1 ---"
puts "What is the encryption weakness in your XMAS-encrypted list of numbers?"
puts ans_two = crwlr.scan_for(ans_one)
