#!/usr/bin/env ruby
puts '--- Day 2 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_02.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT
CUBE_COUNTS = {
  'red' => 12,
  'green' => 13,
  'blue' => 14
}

class DayTwo
  def initialize
    @possibles = 0
    @powers = []
    process(INPUT.dup)
  end

  def process(lines)
    lines.each do |line|
      possible = true
      id = line.match(/(\d+):/)[1].to_i
      power = 1
      CUBE_COUNTS.each do |color, max|
        highest = find_highest(color, line)
        if highest > CUBE_COUNTS[color]
          possible = false
        end
        power = power * highest
      end
      @possibles += id if possible
      @powers << power
    end
  end

  def find_highest(color, line)
    regex = "(\\d+) #{color}"
    matches = line.scan(/#{regex}/).flatten.map(&:to_i)
    matches.max
  end

  def part_one
    puts @possibles
  end

  def part_two
    puts @powers.sum
  end
end

day_two = DayTwo.new
puts '--- Part 1 ---'
puts day_two.part_one
puts '--- Part 2 ---'
puts day_two.part_two
