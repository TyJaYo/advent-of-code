#!/usr/bin/env ruby
puts '--- Day 10 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_10.txt'.freeze
INPUT = File.readlines(PATH, chomp: true)
puts "Successfully read input from #{PATH}" if INPUT
DIRS = {
  n: [0, 1],
  e: [1, 0],
  s: [0, -1],
  w: [-1, 0]
}
CONNEX = {
  n: ['|', 'F', '7', 'S'],
  e: ['-', 'J', '7', 'S'],
  s: ['|', 'J', 'L', 'S'],
  w: ['-', 'F', 'L', 'S']
}

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

  def find_loop
    find_s
    follow_pipe
  end

  def find_s
    @rows.each do |y_dx, line|
      if line.include?('S')
        @loc = [y_dx, line.index('S')]
        return
      end
    end
  end

  def follow_pipe
    scurry_from(@loc)
  end

  def scurry_from(loc)
    x, y = loc
    @visited << loc
# puts "loc: #{loc}"
    DIRS.each do |dir, offsets|
      x_off, y_off = offsets
      new_x, new_y = [x + x_off, y + y_off]
      found_symbol = @rows[new_y][new_x]
      # puts "found_symbol: #{found_symbol}"
      if CONNEX[dir].include?(found_symbol) && !@visited.include?([new_x, new_y])
        @loop << found_symbol
        puts @loop.inspect
        return if found_symbol == 'S'

        scurry_from([new_x, new_y])
      end
    end
    # puts "==="
  end

  def part_one
    find_loop
    puts @loop.inspect
    puts (@loop.size / 2).ceil
  end

  def part_two
  end
end

day_nine = DayTen.new
puts '--- Part 1 ---'
puts day_nine.part_one
puts '--- Part 2 ---'
puts day_nine.part_two
