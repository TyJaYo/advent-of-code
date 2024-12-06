#!/usr/bin/env ruby
puts '--- Day 6 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_06.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DaySix
  def initialize
    @map = {}
    @guard_position = []
    @visited_squares = []
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, ldex|
      line.strip.chars.each_with_index do |char, cdex|
        @map[[cdex, ldex]] = char
        if char == '^'
          @map[[cdex, ldex]] = '.'
          @guard_position = [cdex, ldex]
        end
      end
    end
  end

  def part_one
    patrol_from(*@guard_position)
    report(count_visited_squares)
  end

  def patrol_from(x, y)
    compass = [:north, :east, :south, :west]
    deltas = {
      north: [0, -1],
      east: [1, 0],
      south: [0, 1],
      west: [-1, 0]
    }

    queue = [[x, y, compass.dup]]

    until queue.empty?
      current_x, current_y, compass = queue.shift
      @visited_squares << [current_x, current_y]

      current_heading = compass.first
      dx, dy = deltas[current_heading]
      next_square_coords = [current_x + dx, current_y + dy]
      next_square_content = @map.fetch(next_square_coords, nil)

      case next_square_content
      when nil then next
      when '.' then queue.push([*next_square_coords, compass.dup])
      when '#' then queue.push([current_x, current_y, compass.rotate])
      end
    end
  end

  def count_visited_squares
    @visited_squares.uniq.count
  end

  def report(count)
    puts "The guard visited #{count} squares."
    system("echo #{count} | pbcopy")
    puts 'Copied to clipboard!'
  end

  def part_two
  end
end

day_six = DaySix.new
puts '--- Part 1 ---'
day_six.part_one
puts '--- Part 2 ---'
day_six.part_two
