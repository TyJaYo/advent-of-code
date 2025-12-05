#!/usr/bin/env ruby
puts '--- Day 3 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_03.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayThree
  def initialize
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
       = line.split.map(&:to_i)
    end
  end

  def part_one
    system("echo #{} | pbcopy")
    puts 'Copied to clipboard!'
  end

  def part_two
  end
end

day_three = DayThree.new
puts '--- Part 1 ---'
day_three.part_one
puts '--- Part 2 ---'
day_three.part_two
