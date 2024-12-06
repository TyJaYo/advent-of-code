#!/usr/bin/env ruby
puts '--- Day 6 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_06.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

COLORS = {
  red: "\e[31m",
  green: "\e[32m",
  yellow: "\e[33m",
  blue: "\e[34m",
  magenta: "\e[35m",
  cyan: "\e[36m",
  white: "\e[37m",
  reset: "\e[0m"
}.freeze

class DaySix
  def initialize
    @map = {}
    @guard_position = []
    @visited_squares = {}
    @looping_path_count = 0
    process(INPUT)
    @color = COLORS[:reset]
  end

  def process(lines)
    lines.each_with_index do |line, ldex|
      line.strip.chars.each_with_index do |char, cdex|
        @map[[cdex, ldex]] = char
        if char == '^'
          @map[[cdex, ldex]] = '^'
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
      current_heading = compass.first

      if @visited_squares[[current_x, current_y]] == current_heading
        @looping_path_count += 1
        break
      else
        @visited_squares[[current_x, current_y]] = current_heading
      end

      dx, dy = deltas[current_heading]
      next_square_coords = [current_x + dx, current_y + dy]
      next_square_content = @map.fetch(next_square_coords, nil)

      case next_square_content
      when nil then next
      when '.' then queue.push([*next_square_coords, compass.dup])
      when '^' then queue.push([*next_square_coords, compass.dup])
      when '#' then queue.push([current_x, current_y, compass.rotate])
      end
    end
  end

  def count_visited_squares
    @visited_squares.uniq.count
  end

  def report(count, part = 1)
    case part
    when 1 then puts "The guard visited #{count} squares."
    when 2 then puts "#{count} obstruction locations loop the guard."
    end
    system("echo #{count} | pbcopy")
    puts 'Copied to clipboard!'
  end

  def part_two
    patrol_with_added_obstructions
    report(@looping_path_count, 2)
  end

  def patrol_with_added_obstructions
    @map.each do |(x, y), char|
      @visited_squares.clear
      next unless char == '.'

      @map[[x, y]] = '#'
      patrol_from(*@guard_position)
      # print_map
      @map[[x, y]] = '.'
    end
  end

  def print_map
    @map.each do |(x, y), char|
      @color = @visited_squares.key?([x, y]) ? COLORS[:red] : COLORS[:reset]
      print "#{@color}#{char}#{COLORS[:reset]}"
      puts if x == @map.keys.max[0]
    end
    puts
  end
end

day_six = DaySix.new
puts '--- Part 1 ---'
day_six.part_one
puts '--- Part 2 ---'
day_six.part_two
