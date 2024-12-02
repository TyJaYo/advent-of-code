#!/usr/bin/env ruby
puts '--- Day 2 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_02.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayTwo
  def initialize
    @reports = []
    @safe = 0
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      levels = line.split.map(&:to_i)
      @reports << levels
    end
  end

  def evaluate_safety(reports)
    reports.each do |levels|
      @safe += 1 if consistent?(levels) && gradual?(levels)
    end
  end

  def consistent?(levels)
    differences = levels.each_cons(2).map { |a, b| a - b }
    differences.all?(&:positive?) || differences.all?(&:negative?)
  end

  def gradual?(levels)
    levels.each_cons(2).all? { |a, b| (a - b).abs.between?(1, 3) }
  end

  def part_one
    evaluate_safety(@reports)
    puts "There are #{@safe} safe reports"
    system("echo #{@safe} | pbcopy")
    puts 'Copied to clipboard!'
  end
end

day_two = DayTwo.new
puts '--- Part 1 ---'
day_two.part_one
puts '--- Part 2 ---'
# day_two.part_two
