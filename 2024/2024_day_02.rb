#!/usr/bin/env ruby
puts '--- Day 2 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_02.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayTwo
  def initialize
    @new_reports = []
    @safe_reports = []
    @unsafe_reports = []
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      levels = line.split.map(&:to_i)
      @new_reports << levels
    end
  end

  def evaluate_safety(reports)
    reports.each do |levels|
      if safe?(levels)
        @safe_reports << levels
      else
        @unsafe_reports << levels
      end
    end
  end

  def safe?(levels)
    is_increasing_gradually = levels.each_cons(2).all? do |a, b|
      a < b && (b - a).between?(1, 3)
    end
    return true if is_increasing_gradually

    is_decreasing_gradually = levels.each_cons(2).all? do |a, b|
      a > b && (a - b).between?(1, 3)
    end

    is_decreasing_gradually
  end

  def part_one
    evaluate_safety(@new_reports)
    report(@safe_reports.count, 'Safe Reports')
  end

  def report(value, name = nil)
    puts "#{name}: #{value}"
    system("echo #{value} | pbcopy")
    puts "Copied to clipboard!"
  end

  def part_two
    approximate_safety
    report(@safe_reports.count, 'Safe Reports')
  end

  def approximate_safety
    @unsafe_reports.each do |levels|
      levels.each_with_index do |_, index|
        new_levels = levels.dup
        new_levels.delete_at(index)
        if safe?(new_levels)
          @safe_reports << new_levels
          break
        end
      end
    end
  end
end

day_two = DayTwo.new
puts '--- Part 1 ---'
day_two.part_one
puts '--- Part 2 ---'
day_two.part_two
