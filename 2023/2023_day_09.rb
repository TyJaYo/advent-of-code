#!/usr/bin/env ruby
puts '--- Day 9 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_09.txt'.freeze
INPUT = File.readlines(PATH)
puts "Successfully read input from #{PATH}" if INPUT

class DayNine
  def initialize
    @numses = {}
    @next_nums = []
    @prev_nums = []
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, dx|
      @numses[dx] = line.split.map(&:to_i)
    end
  end

  def find_next_nums
    @numses.each do |_, nums|
      @next_nums << next_num(nums)
    end
  end

  def find_prev_nums
    @numses.each do |_, nums|
      @prev_nums << prev_num(nums)
    end
  end

  def prev_num(sequence)
    og_sequence = sequence.dup
    differences = []

    until sequence.all? { |e| e == 0 }
      sequence = sequence.each_cons(2).map { |a, b| b - a }
      differences << sequence
    end

    dx_skip = differences.size - 2
    differences.reverse.each_with_index do |diff, dx|
      next_item = differences[dx_skip - dx]
      break unless next_item

      next_item.unshift(next_item.first - diff.first)
    end

    og_sequence.unshift(og_sequence.first - differences.first.first)
    og_sequence.first
  end

  def next_num(sequence)
    og_sequence = sequence.dup
    differences = []

    while sequence.uniq.length > 1
      sequence = sequence.each_cons(2).map { |a, b| b - a }
      differences << sequence
    end

    differences.reverse.each do |diff|
      og_sequence << og_sequence.last + diff.last
    end

    og_sequence.last
  end

  def part_one
    find_next_nums
    puts @next_nums.sum
  end

  def part_two
    find_prev_nums
    puts @prev_nums.sum
  end
end

day_nine = DayNine.new
puts '--- Part 1 ---'
puts day_nine.part_one
puts '--- Part 2 ---'
puts day_nine.part_two
