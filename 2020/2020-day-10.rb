#!/usr/bin/env ruby
puts "--- Day 10: Adapter Array ---"
puts "--- Part 0: Parse Input ---"
PATH = './inputs/day-10.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).map(&:to_i).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts "--- Part 1: Find joltage jumps ---"
class DaisyChainer
  def initialize
    @adapters = [0] + INPUT.dup + [INPUT.max + 3]
    @difs = []
  end

  def run
    sort
    jump
    report
  end

  def sort
    @adapters.sort!
  end

  def jump
    @adapters.each_with_index do |adapter, i|
      next if i == 0
      dif = adapter - @adapters[i - 1]
      @difs << dif
    end
  end

  def report
    ones   = @difs.count(1)
    threes = @difs.count(3)
    puts "What is the number of 1-jolt differences multiplied by the number of 3-jolt differences?"
    puts "#{ones} × #{threes} = #{ones * threes}"
  end
end

dc = DaisyChainer.new
dc.run
