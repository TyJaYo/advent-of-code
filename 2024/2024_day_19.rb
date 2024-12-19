#!/usr/bin/env ruby
puts '--- Day 19 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_19.txt'.freeze
INPUT = File.read(PATH).freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayNineteen
  def initialize
    process(INPUT)
  end

  def process(line)
    available_patterns, desired_designs = line.split("\n\n")
    @available_patterns = available_patterns.split(", ")
    @desired_designs = desired_designs.split("\n")
  end

  def part_one
    determine_possible_designs
    report(@possible_designs.size, 'Possible Designs')
  end

  def part_two
    total_ways = 0
    @possible_designs.each do |design|
      total_ways += count_ways(design, @available_patterns)
    end
    report(total_ways, 'Total Ways to Construct Designs')
  end

  def determine_possible_designs
    @possible_designs = []
    @desired_designs.each do |design|
      if can_construct?(design, @available_patterns)
        @possible_designs << design
      end
    end
  end

  def can_construct?(design, patterns, memo = {})
    return true if design.empty?
    return memo[design] if memo.key?(design)

    patterns.each do |pattern|
      if design.start_with?(pattern)
        suffix = design[pattern.length..-1]
        if can_construct?(suffix, patterns, memo)
          memo[design] = true
          return true
        end
      end
    end

    memo[design] = false
    false
  end

  def count_ways(design, patterns, memo = {})
    return 1 if design.empty?
    return memo[design] if memo.key?(design)

    total_ways = 0
    patterns.each do |pattern|
      if design.start_with?(pattern)
        suffix = design[pattern.length..-1]
        total_ways += count_ways(suffix, patterns, memo)
      end
    end

    memo[design] = total_ways
    total_ways
  end

  def report(value, name = nil)
    puts "#{name}: #{value}"
    system("echo #{value} | pbcopy")
    puts "Copied to clipboard!"
  end
end

day_nineteen = DayNineteen.new
puts '--- Part 1 ---'
day_nineteen.part_one
puts '--- Part 2 ---'
day_nineteen.part_two
