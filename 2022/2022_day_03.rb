#!/usr/bin/env ruby
puts '--- Day 3: Rucksack Reorganization ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_03.txt'.freeze
INPUT = File.open(PATH).readlines.map { |l| l.split("\n") }.map { |l| l.first.take(l.length / 2) }.freeze
puts "Successfully read input from #{PATH}" if INPUT

puts '--- Part 1: Find sum of priorities ---'
class RucksackParser
  def initialize
    @priority_map = PMap.new
    @priority_sum = 0
  end

  def run
    INPUT.each do |line|
      calculate(parse(line))
    end
    report
  end

  def parse(line)
  end

  def report
    puts @priority_sum
  end
end

class PMap
  def initialize
    input = INPUT.dup
  end
end

rp = RucksackParser.new
rp.run
