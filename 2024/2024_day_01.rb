#!/usr/bin/env ruby
puts '--- Day 1 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_01.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayOne
  def initialize
    @column_one = []
    @column_two = []
    @differences = []
    @similarities = []
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      numbers = line.split.map(&:to_i)
      @column_one << numbers.first
      @column_two << numbers.last
    end
    @column_one.sort!
    @column_two.sort!
  end

  def calculate_differences(column_one, column_two)
    column_one.each_with_index do |num, index|
      @differences << (num - column_two[index]).abs
    end
  end

  def calculate_similarity_score(column_one, column_two)
    column_one.each do |num|
      column_two_count = column_two.count(num)
      similarity_score = column_two_count * num
      @similarities << similarity_score
    end
  end

  def part_one
    calculate_differences(@column_one, @column_two)
    tot(@differences)
  end

  def part_two
    calculate_similarity_score(@column_one, @column_two)
    tot(@similarities)
  end

  def tot(arr)
    sum = arr.sum
    puts sum
    system("echo #{sum} | pbcopy")
    puts 'Copied to clipboard'
  end
end

day_one = DayOne.new
puts '--- Part 1 ---'
day_one.part_one
puts '--- Part 2 ---'
day_one.part_two
