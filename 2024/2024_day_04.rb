#!/usr/bin/env ruby
puts '--- Day 4 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_04.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayFour
  def initialize
    @map = {}
    @xs = []
    @as = []
    @stroke_count = 0
    @xmas_found = 0
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, y|
      columns = line.strip.chars
      columns.each_with_index do |char, x|
        @map[x] ||= {}
        @map[x][y] = char
      end
    end
  end

  def scan_for_x
    @map.each do |x, row|
      row.each do |y, char|
        @xs << [x, y] if char == 'X'
      end
    end
  end

  def scan_for_mas
    @xs.each do |x, y|
      loopy_look(x, y)
    end
  end

  def scan_for_a
    @map.each do |x, row|
      row.each do |y, char|
        @as << [x, y] if char == 'A'
      end
    end
  end

  def x_ray_for_m_s
    @as.each do |x, y|
      @stroke_count = 0
      x_ray(x, y)
    end
  end

  def loopy_look(x, y, dx = [-1, 0, 1], dy = [-1, 0, 1], sequence = %w(M A S))
    dx.product(dy).each do |ddx, ddy|
      next if ddx == 0 && ddy == 0
      new_x = x + ddx
      new_y = y + ddy
      next if new_x < 0 || new_y < 0 || new_x >= @map.size || new_y >= @map[new_x].size
      if @map[new_x][new_y] == sequence.first
        remaining_sequence = sequence[1..-1]
        if remaining_sequence.empty?
          @xmas_found += 1
          next
        end
        loopy_look(new_x, new_y, [ddx], [ddy], remaining_sequence)
      end
    end
  end

  def x_ray(x, y, dx = [-1, 1], dy = [-1, 1], sequence = %w(M S))
    dx.product(dy).each do |ddx, ddy|
      new_x = x + ddx
      new_y = y + ddy
      next if new_x < 0 || new_y < 0 || new_x >= @map.size || new_y >= @map[new_x].size
      if @map[new_x][new_y] == sequence.first
        remaining_sequence = sequence[1..-1]
        if remaining_sequence.empty?
          @stroke_count += 1
          next
        end
        x_ray(x, y, [ddx * -1], [ddy * -1], remaining_sequence)
      end
    end
    if @stroke_count == 2
      @xmas_found += 1
      @stroke_count = 0
    end
  end

  def part_one
    scan_for_x
    scan_for_mas
    puts "Found #{@xmas_found} instances of 'XMAS'"
    system("echo '#{@xmas_found}' | pbcopy")
    puts 'Copied to clipboard!'
  end

  def part_two
    @xmas_found = 0
    scan_for_a
    x_ray_for_m_s
    puts "Found #{@xmas_found} Xs of 'MAS'"
    system("echo '#{@xmas_found}' | pbcopy")
    puts 'Copied to clipboard!'
  end
end

day_four = DayFour.new
puts '--- Part 1 ---'
day_four.part_one
puts '--- Part 2 ---'
day_four.part_two
