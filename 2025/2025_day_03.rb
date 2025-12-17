#!/usr/bin/env ruby
puts '--- Day 3 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_03.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayThree
  def initialize
    @banks = {}
    @joltage_maxes = []
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, line_index|
      line.chars.each_with_index do |char, index|
        @banks[line_index] ||= []
        @banks[line_index] << {
          position: index,
          joltage: char.to_i
        }
      end
    end
  end

  def part_one
    calculate_maxes(@banks)
    show(@joltage_maxes.sum)
  end

  def calculate_maxes(banks, battery_count = 2)
    banks.each do |_, bank|
      bank_length = bank.length
      range_start = 0
      remaining_batteries = battery_count
      maxes = []
      until remaining_batteries == 0
        range_end = bank_length - remaining_batteries
        max, max_pos = max_in_range(bank, range_start...range_end)
        range_start = max_pos + 1
        remaining_batteries -= 1
        maxes << max.to_s
      end
      @joltage_maxes << maxes.join.to_i
    end
  end

  def max_in_range(bank, range)
    max_joltage = -1
    max_position = -1
    bank[range].each do |entry|
      if entry[:joltage] > max_joltage
        max_joltage = entry[:joltage]
        max_position = entry[:position]
      end
    end
    [max_joltage, max_position]
  end

  def part_two
    calculate_maxes(@banks, 12)
    show(@joltage_maxes.sum)
  end

  def show(result)
    puts result
    system("echo #{result} | pbcopy")
    puts 'Copied to clipboard'
  end
end

day_three = DayThree.new
puts '--- Part 1 ---'
day_three.part_one

day_three = DayThree.new
puts '--- Part 2 ---'
day_three.part_two
