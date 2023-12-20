#!/usr/bin/env ruby
INPUT_PATH = './inputs/day_20.txt'
INPUT = File.readlines(INPUT_PATH, chomp: true)

class DayTwenty
  def initialize
    @insts = []
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      dir, len, hue = line.scan(/^(\w)\s(\d)\s\(#(\w+)/)[0]
      hue = hue.chars.each_slice(2).map(&:join).map(&:hex)
      @insts << [dir.to_sym, len.to_i, hue]
    end
  end

  def part_one
  end

  def part_two
  end
end

puts '--- Day 20 ---'
day_twenty = DayTwenty.new
puts '--- Part 1 ---'
day_twenty.part_one
puts '--- Part 2 ---'
day_twenty.part_two
