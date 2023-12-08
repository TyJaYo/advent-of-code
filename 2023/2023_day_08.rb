#!/usr/bin/env ruby
puts '--- Day 8 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_08.txt'.freeze
INPUT = File.readlines(PATH, chomp: true)
puts "Successfully read input from #{PATH}" if INPUT

class DayEight
  def initialize
    @nodes = {}
    @steps = 0
    process(INPUT)
  end

  def process(lines)
    @instructions = lines.shift(2)[0].chars.map(&:to_sym)
    lines.each do |line|
      node, left, right = line.scan(/\w{3}/)
      @nodes[node] = { L: left, R: right }
    end
  end

  def follow_instructions
    current_node = 'AAA'
    @instructions.cycle do |instruction|
      next_node = @nodes[current_node][instruction]
      @steps += 1
      current_node = next_node
      break if current_node == 'ZZZ'
    end
  end

  def follow_ghost_instructions
    current_nodes = @nodes.keys.select { |key| key[-1] == 'A' }
    @instructions.cycle do |instruction|
      next_nodes = []
      current_nodes.each do |node|
        next_nodes << @nodes[node][instruction]
      end
      @steps += 1
      current_nodes.replace(next_nodes)
      break if current_nodes.all? { |key| key[-1] == 'Z' }
    end
  end

  def part_one
    follow_instructions
    puts @steps
  end

  def part_two
    @steps = 0
    follow_ghost_instructions
    puts @steps
  end
end

day_eight = DayEight.new
puts '--- Part 1 ---'
puts day_eight.part_one
puts '--- Part 2 ---'
# puts day_eight.part_two -- too slow
