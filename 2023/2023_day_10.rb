#!/usr/bin/env ruby
require 'colorize'

puts '--- Day 10 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_10.txt'.freeze
INPUT = File.readlines(PATH, chomp: true)
puts "Successfully read input from #{PATH}" if INPUT
DIRS = {
  n: [0, -1],
  e: [1, 0],
  s: [0, 1],
  w: [-1, 0]
}
CONNEX = {
  n: ['|', 'F', '7'],
  e: ['-', 'J', '7'],
  s: ['|', 'J', 'L'],
  w: ['-', 'F', 'L']
}
TOPS    = ['|', 'J', 'L', 'S']
BOTTOMS = ['|', '7', 'F', 'S']

class DayTen
  def initialize
    @rows = {}
    @loop = []
    @visited = []
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, dx|
      @rows[dx] = line.chars
    end
  end

  def run_loop
    scurry(*look_around(find_s))
  end

  def find_s
    @rows.each do |y_dx, line|
      if line.include?('S')
        return [line.index('S'), y_dx]
      end
    end
  end

  def look_around(loc)
    DIRS.each do |dir, offsets|
      looked_loc = offset_loc(loc, offsets)
      found_symbol = find_symbol(looked_loc)
      if CONNEX[dir].include?(found_symbol)
        return [dir, found_symbol, looked_loc]
      end
    end
  end

  def offset_loc(loc, offsets)
    [loc[0] + offsets[0], loc[1] + offsets[1]]
  end

  def find_symbol(loc)
    @rows[loc[1]][loc[0]]
  end

  def scurry(dir, symbol, loc)
    @loop << symbol
    @visited << loc

    loop do
      next_dir = case [dir, symbol]
      when [:n, '|'] then :n
      when [:n, 'F'] then :e
      when [:n, '7'] then :w
      when [:e, '-'] then :e
      when [:e, 'J'] then :n
      when [:e, '7'] then :s
      when [:s, '|'] then :s
      when [:s, 'J'] then :w
      when [:s, 'L'] then :e
      when [:w, '-'] then :w
      when [:w, 'L'] then :n
      when [:w, 'F'] then :s
      end

      next_loc = offset_loc(loc, DIRS[next_dir])
      symbol = find_symbol(next_loc)
      @loop << symbol
      @visited << next_loc

      break if symbol == 'S'

      dir = next_dir
      loc = next_loc
    end
  end

  def part_one
    run_loop
    puts (@loop.size / 2).ceil
  end

  def update_symbol(sym)
    case sym
    when 'F' then '┏'
    when '7' then '┓'
    when 'J' then '┛'
    when 'L' then '┗'
    when '-' then '━'
    when '|' then '┃'
    else '┼'
    end
  end

  def print_rows
    @rows.each do |y_dx, row|
      row.each_with_index do |sym, x_dx|
        point = [x_dx, y_dx]
        new_sym = update_symbol(sym)
        if @enclosed.include?(point)
          print new_sym.red
        elsif !@visited.include?(point)
          print new_sym.blue
        else
          print new_sym
        end
      end
      print "\n"
    end
  end

  def check_points
    @enclosed = []
    buffer = []

    @rows.each do |y_dx, row|
      out = true

      row.each_with_index do |row, x_dx|
        point = [x_dx, y_dx]
        symbol = find_symbol(point)
        visited = @visited.include?(point)

        if visited
          buffer << 'top' if TOPS.include?(symbol)
          buffer << 'bottom' if BOTTOMS.include?(symbol)
        end

        if buffer.size == 2
          if buffer.uniq.size == 2
            out = !out
          end
          buffer.clear
        end

        unless out || visited
          @enclosed << point
        end
      end
    end
  end

  def part_two
    check_points
    print_rows
    puts @enclosed.count
  end
end

day_ten = DayTen.new
puts '--- Part 1 ---'
day_ten.part_one
puts '--- Part 2 ---'
day_ten.part_two
