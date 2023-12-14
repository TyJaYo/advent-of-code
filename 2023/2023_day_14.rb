#!/usr/bin/env ruby
INPUT_PATH = './inputs/day_14.txt'
INPUT = File.readlines(INPUT_PATH, chomp: true)

class DayFourteen
  def initialize
    @rows = []
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      @rows << line.chars
    end
  end

  def show_platform
    @rows.each do |row|
      row.each do |char|
        print char
      end
      print "\n"
    end
  end

  def tilt_platform
    @rows.each_with_index do |row, y_dx|
      row.each_with_index do |char, x_dx|
        if char == 'O'
          move_up_from(x_dx, y_dx)
        end
      end
    end
  end

  def move_up_from(x_dx, y_dx)
    while @rows[y_dx - 1][x_dx] == '.' && y_dx > 0
      @rows[y_dx][x_dx] = '.'
      @rows[y_dx - 1][x_dx] = 'O'
      y_dx -= 1
    end
  end

  def calc_load
    multiplier = 0
    @rows.reverse.sum do |row|
      multiplier += 1
      row_sum = row.sum do |char|
        char == 'O' ? 1 : 0
      end
      row_sum * multiplier
    end
  end

  def rotate_platform
    @rows = @rows.transpose.each { |col| col.reverse! }
  end

  def part_one
    tilt_platform
    puts calc_load
  end

  def part_two
    1_000_000_000.times do
      4.times do
        tilt_platform
        rotate_platform
      end
    end
    show_platform
    puts calc_load
  end
end

puts '--- Day 14 ---'
puts '--- Part 1 ---'
day_fourteen = DayFourteen.new
day_fourteen.part_one
puts '--- Part 2 ---' # too slow
# day_fourteen = DayFourteen.new
# day_fourteen.part_two
