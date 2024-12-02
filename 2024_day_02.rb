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

  def part_two
    @safe = 0
    approximate_safety(@reports)
    puts "There are #{@safe} reports that are more or less safe"
  end

  def approximate_safety(reports)
    reports.each do |levels|
      @safe += 1 if more_or_less_consistent?(levels) && more_or_less_gradual?(levels)
    end
  end

  def more_or_less_consistent?(levels)
    differences = levels.each_cons(2).map { |a, b| a - b }
    positive_indices = []
    negative_indices = []
    differences.each_with_index do |diff, index|
      positive_indices << (index + 1) if diff.positive?
      negative_indices << (index + 1) if diff.negative?
    end
    if positive_indices.empty? || negative_indices.empty?
      puts "#{levels} is consistent"
      return true
    end

    if positive_indices.one? && consistent?(differences.reject.with_index { |_, index| index == positive_indices.first })
      puts "#{levels} is more or less consistent after removing #{levels[positive_indices.first]}"
      return true
    end

    if negative_indices.one? && consistent?(differences.reject.with_index { |_, index| index == negative_indices.first })
      puts "#{levels} is more or less consistent after removing #{levels[negative_indices.first]}"
      return true
    end

    false
  end

  def more_or_less_gradual?(levels)
    deltas = levels.each_cons(2).map { |a, b| (a - b).abs }
    small_indices = []
    large_indices = []
    deltas.each_with_index do |delta, index|
      small_indices << index if delta.between?(1, 3)
      large_indices << index if delta > 3
    end
    if large_indices.empty?
      puts "#{levels} is gradual"
      return true
    end

    if large_indices.one? && gradual?(levels.reject.with_index { |_, index| index == large_indices.first })
      puts "#{levels} is more or less gradual after removing #{levels[large_indices.first]}"
      return true
    end

    false
  end
end

day_two = DayTwo.new
puts '--- Part 1 ---'
day_two.part_one
puts '--- Part 2 ---'
day_two.part_two
