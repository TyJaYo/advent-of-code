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
    @number_id = 0
    build_maps(INPUT)
  end

  def scan_around_numbers
    @number_map.each do |id, data|
      number, locs = data[:number], data[:locs]
      locs_to_check = []

      locs.each { |loc| locs_to_check += find_neighbors(loc) }
      locs_to_check.uniq!
      locs_to_check.delete_if { |loc| locs.include?(loc) }

      locs_to_check.each do |loc|
        if @symbol_map.has_key?(loc)
          @number_map[id][:symbol] = @symbol_map[loc]
        end
      end
    end
  end

  def scan_around_gears
    @symbol_map.delete_if { |_, value| value != "*" }
    @symbol_map.each do |loc, _|
      number_neighbors = []
      find_neighbors(loc).each do |neighbor|
        number_neighbors << @number_map.select { |_, value|
          value[:locs].any? { |loc| loc == neighbor }
        }.keys
      end
      @symbol_map[loc] = number_neighbors.uniq.flatten
    end
  end

  def calculate_gear_ratios
    @symbol_map.delete_if { |_, value| value.size != 2 }
    @symbol_map.each do |loc, number_ids|
      @symbol_map[loc] = @number_map[number_ids[0]][:number] * @number_map[number_ids[1]][:number]
    end
  end

  def find_neighbors(loc)
    x, y      = loc
    neighbors = []

    max_x   ||= INPUT[0].chomp.size - 1
    max_y   ||= INPUT.size - 1
    offsets ||= [-1, 0, 1]

    offsets.product(offsets) do |x_offset, y_offset|
      new_x = x + x_offset
      new_y = y + y_offset

      if (0..max_x).include?(new_x) && (0..max_y).include?(new_y)
        neighbors << [new_x, new_y]
      end
    end

    neighbors.delete(loc)
    neighbors
  end

  def build_maps(lines)
    lines.each_with_index do |line, y_dx|
      @last_line_dx ||= line.size - 1
      line.chars.each_with_index do |char, x_dx|
        case char
        when /\d/ then @num_chars << char
        else
          map_number(x_dx - 1, y_dx)
          @symbol_map[[x_dx, y_dx]] = char unless char.match?(/\.|\n/)
        end
      end
    end
  end

  def map_number(x_dx, y_dx)
    return if @num_chars.empty?

    number = @num_chars.join.to_i
    locs = []

    @num_chars.each_with_index do |_, dx|
      locs << [x_dx - dx, y_dx]
    end

    @number_map[@number_id + 1] = { number: number, locs: locs }
    @number_id += 1
    @num_chars = []
  end

  def part_one
    scan_around_numbers
    total = @number_map.select { |_, data|
      data.has_key?(:symbol) && !data[:symbol].empty?
    }.map { |_, data| data[:number] }.sum
    puts total
  end

  def part_two
    scan_around_gears
    calculate_gear_ratios
    puts @symbol_map.values.sum
  end
end

day_three = DayThree.new
puts '--- Part 1 ---'
puts day_three.part_one
puts '--- Part 2 ---'
puts day_three.part_two
