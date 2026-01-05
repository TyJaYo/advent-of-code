#!/usr/bin/env ruby
puts '--- Day 4 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_04.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayFour
  def initialize
    @map = {}
    @removed_rolls = 0
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, line_index|
      line.chars.each_with_index do |char, index|
        @map[line_index] ||= []
        @map[line_index] << {
          position: index,
          symbol: char,
          reachable: false
        }
      end
    end
  end

  def part_one
    find_reachable(@map)
    show(add_reachable(@map))
  end

  def find_reachable(map)
    map.each do |row_no, line|
      line.each do |entry|
        if entry[:symbol] == '@'
          neighbor_count = check_neighbors(map, row_no, entry[:position])
          if neighbor_count < 4
            entry[:reachable] = true
          end
        else
          entry[:reachable] = false
        end
      end
    end
  end

  def check_neighbors(map, row_no, position)
    count = 0
    directions = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
    directions.each do |dir|
      new_row = row_no + dir[0]
      new_pos = position + dir[1]
      if map[new_row] && map[new_row][new_pos]
        neighbor = map[new_row][new_pos]
        if neighbor[:symbol] == '@'
          count += 1
        end
      end
    end
    count
  end

  def add_reachable(map)
    map.values.flatten.count { |entry| entry[:reachable] }
  end

  def remove_rolls(map)
    @newly_removed_rolls = 0
    map.each do |row_no, line|
      line.map do |entry|
        if entry[:reachable]
          # puts "Removing roll at row #{row_no}, position #{entry[:position]}"
          @map[row_no][entry[:position]][:symbol] = '.'
          @removed_rolls += 1
          @newly_removed_rolls += 1
        end
      end
    end
    # print_map(map)
  end

  def part_two
    find_reachable(@map)
    # print_map(@map)
    until @newly_removed_rolls == 0
      remove_rolls(@map)
      find_reachable(@map)
    end
    show(@removed_rolls)
  end

  def print_map(map)
    map.each do |_, line|
      line_str = line.map do |entry|
        # if entry[:reachable]
        #   entry[:symbol] = 'x'
        # end
        entry[:symbol]
      end.join
      puts line_str
    end
    sleep(1)
  end

  def show(result)
    puts result
    system("echo #{result} | pbcopy")
    puts 'Copied to clipboard'
  end
end

day_four = DayFour.new
puts '--- Part 1 ---'
day_four.part_one

day_four = DayFour.new
puts '--- Part 2 ---'
day_four.part_two
