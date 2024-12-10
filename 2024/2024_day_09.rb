#!/usr/bin/env ruby
puts '--- Day 9 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_09.txt'.freeze
INPUT = File.read(PATH).freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayNine
  def initialize
    @blocks = {}
    @checksum = 0
    @disk_map = parse(INPUT)
  end

  def parse(input)
    input.strip.chars.map(&:to_i)
  end

  def process(disk_map)
    index = 0
    file_index = 0
    enter_file_index = true
    disk_map.each do |num|
      num.times do
        if enter_file_index
          @blocks[index] = file_index
        else
          @blocks[index] = '.'
        end
        index += 1
      end
      file_index += 1 if enter_file_index
      enter_file_index = !enter_file_index
    end
  end

  def compact_files(blocks)
    rightmost_file = blocks.keys.select { |k| blocks[k] != '.' }.max
    rightmost_file.downto(0) do |i|
      next if blocks[i] == '.'

      leftmost_free = blocks.keys.find { |k| blocks[k] == '.' }
      break if leftmost_free > i

      blocks[leftmost_free] = blocks[i]
      blocks[i] = '.'
    end
  end

  def calculate_checksum(blocks)
    blocks.each do |position, file_id|
      next if file_id == '.'

      @checksum += position * file_id
    end
  end

  def part_one
    process(@disk_map)
    compact_files(@blocks)
    calculate_checksum(@blocks)
    report(@checksum)
  end

  # def print_out(blocks)
  #   blocks.keys.each_slice(100) do |slice|
  #     slice.each { |k| print blocks[k] }
  #     puts
  #   end
  # end

  def report(checksum)
    puts "The checksum is: #{checksum}"
    system("echo #{checksum} | pbcopy")
    puts 'Copied to clipboard!'
  end

  def part_two
  end
end

day_nine = DayNine.new
puts '--- Part 1 ---'
day_nine.part_one
puts '--- Part 2 ---'
day_nine.part_two
