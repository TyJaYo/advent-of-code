#!/usr/bin/env ruby
puts '--- Day 2 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_02.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayTwo
  def initialize
    @ranges = []
    @invalids = []
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      line.split(',').each do |range|
        @ranges << range.split('-').map(&:to_i)
      end
    end
  end

  def part_one
    count_invalids(@ranges)
    show(@invalids.sum)
  end

  def count_invalids(ranges)
    ranges.each do |range|
      start, finish = range[0], range[-1]
      (start..finish).each do |num|
        str = num.to_s
        next if str.length.odd?
        half = str.length / 2
        first_half = str[0...half]
        last_half = str[-half..-1]
        @invalids << num if first_half == last_half
      end
    end
  end

  def part_two
    count_invalids_pt_2(@ranges)
    show(@invalids.sum)
  end

  def count_invalids_pt_2(ranges)
    ranges.each do |range|
      start, finish = range[0], range[-1]
      (start..finish).each do |num|
        str = num.to_s
        @invalids << num if str.match?(/^(.+)\1+$/)
      end
    end
  end

  def show(result)
    puts result
    system("echo #{result} | pbcopy")
    puts 'Copied to clipboard'
  end
end

day_two = DayTwo.new
puts '--- Part 1 ---'
day_two.part_one

day_two = DayTwo.new
puts '--- Part 2 ---'
day_two.part_two
