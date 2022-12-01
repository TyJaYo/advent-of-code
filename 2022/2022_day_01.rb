#!/usr/bin/env ruby
puts '--- Day 1: Calorie Counting ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_01.txt'.freeze
INPUT = File.open(PATH).readlines.map{ |l| l.split("\n\n") }.map{ |l| l.split("\n") }.map(&:to_i).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts '--- Part 1: Find cal-max cargo ---'
class CalFinder
  def initialize
    @elves = separate(INPUT.dup)
  end

  def separate(lines)
    elves = []
    elf = 0
    lines.each do |line|
      if line.positive?
        elf += line
      else
        elves << elf
        elf = 0
      end
    end
    elves
  end

  def find_max
    @elves.max
  end

  def top_three
    puts @elves.sort.last(3).sum
  end
end

cf = CalFinder.new
puts cf.find_max
puts '--- Part 2: Find cal-max top three ---'
puts cf.top_three
