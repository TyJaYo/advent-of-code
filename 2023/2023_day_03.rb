#!/usr/bin/env ruby
puts '--- Day 3 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_03.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class DayThree
  def initialize
    @number_map = {}
    @symbol_map = {}
    @num_chars = []
    @part_numbers = 0
    build_maps(INPUT.dup)
  end

  def build_maps(lines)
    lines.each_with_index do |line, y_dx|
      @last_line_dx ||= line.size - 1
      line.chars.each_with_index do |char, x_dx|
        case char
        when /\d/ then @num_chars << char
        when /\.|\n/ then map_number(x_dx - 1, y_dx)
        else @symbol_map[[x_dx, y_dx]] = char
        end
      end
    end
  end

  def map_number(x_dx, y_dx)
    return if @num_chars.empty?

    number = @num_chars.join.to_i
    @num_chars.each_with_index do |_, dx|
      @number_map[[x_dx - dx, y_dx]] = number
    end
    @num_chars = []
  end

  def part_one
  end

  def part_two
  end
end

day_three = DayThree.new
puts '--- Part 1 ---'
puts day_three.part_one
puts '--- Part 2 ---'
puts day_three.part_two
