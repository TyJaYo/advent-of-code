#!/usr/bin/env ruby
puts '--- Day 6 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_06.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DaySix
  def initialize
    @columns = []
    @operands = []
    @results = []
    @part_two_hash = {}
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      numbers = line.split.map(&:to_i)
      if numbers.empty?
        next
      elsif numbers.all? { |n| n == 0 }
        @operands = line.split
        next
      elsif @columns.empty?
        @columns = Array.new(numbers.size) { [] }
      end
      numbers.each_with_index do |num, idx|
        @columns[idx] << num
      end
    end
  end

  def part_one
    do_the_math
    show(@results.sum)
  end

  def do_the_math
    @operands.each_with_index do |op, idx|
      col = @columns[idx]
      case op
      when '+'
        @results << col.sum
      when '*'
        @results << col.reduce(1, :*)
      end
    end
  end

  def part_two
    reprocess(INPUT)
    redo_the_math
    show(@results.sum)
  end

  def reprocess(lines)
    index_count = 1
    operands_line = lines[-1]
    current_index = operands_line.length - 1
    operands_line.reverse.chars.each do |char|
      if ['+', '*'].include?(char)
        @part_two_hash[current_index] = { operand: char, index_count: index_count, columns: Array.new(index_count) { [] } }
        index_count = 0
      elsif char == ' '
        index_count += 1
      end
      current_index -= 1
    end
    lines.each do |line|
      chars = line.chars
      break if chars[0] == '*' || chars[0] == '+'

      chars.each_with_index do |char, idx|
        if @part_two_hash.key?(idx)
          (0...@part_two_hash[idx][:index_count]).each do |i|
            @part_two_hash[idx][:columns][i] << chars[idx + i]
          end
        end
      end
    end
  end

  def show(result)
    puts result
    system("echo #{result} | pbcopy")
    puts 'Copied to clipboard'
  end

  def redo_the_math
    @part_two_hash.each do |_, v|
      numbers = []
      v[:columns].each do |col|
        numbers << col.join.to_i
      end
      case v[:operand]
      when '+'
        @results << numbers.sum
      when '*'
        @results << numbers.reduce(1, :*)
      end
    end
  end
end

day_six = DaySix.new
puts '--- Part 1 ---'
day_six.part_one

day_six = DaySix.new
puts '--- Part 2 ---'
day_six.part_two
