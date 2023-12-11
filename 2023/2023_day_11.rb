#!/usr/bin/env ruby
INPUT_PATH = './inputs/day_11.txt'
INPUT = File.readlines(INPUT_PATH, chomp: true)

class DayEleven
  def initialize
    @rows        = {}
    @gal_locs    = []
    @no_gal_rows = Array(0...INPUT.size)
    @no_gal_cols = Array(0...INPUT[0].size)
    @expand_to   = 2
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, y_dx|
      line.chars.each_with_index do |char, x_dx|
        if char == '#'
          @gal_locs << [x_dx, y_dx]
          @no_gal_rows.delete(y_dx)
          @no_gal_cols.delete(x_dx)
        end
      end
      @rows[y_dx] = line.chars
    end
  end

  def find_distances
    @gal_locs.combination(2).sum do |pair|
      loc_1, loc_2 = pair
      x1, x2 = loc_1[0], loc_2[0]
      y1, y2 = loc_1[1], loc_2[1]

      x_slows = count_slows(x1, x2, 'x')
      y_slows = count_slows(y1, y2, 'y')

      x_dist = (x1 - x2).abs + x_slows
      y_dist = (y1 - y2).abs + y_slows

      x_dist + y_dist
    end
  end

  def count_slows(val_1, val_2, axis)
    axis_to_check = case axis
    when 'x' then @no_gal_cols
    when 'y' then @no_gal_rows
    end

    val_1, val_2 = [val_1, val_2].sort

    slows = (val_1 + 1...val_2).sum do |val|
      axis_to_check.include?(val) ? 1 : 0
    end
    slows * (@expand_to - 1)
  end

  def part_one
    puts find_distances
  end

  def part_two
    @expand_to = 1_000_000
    puts find_distances
  end
end

puts '--- Day 11 ---'
day_eleven = DayEleven.new
puts '--- Part 1 ---'
day_eleven.part_one
puts '--- Part 2 ---'
day_eleven.part_two
