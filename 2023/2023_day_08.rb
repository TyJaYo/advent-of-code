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

  def count_steps_from(starting_node)
    @steps = 0
    current_node = starting_node
    @instructions.cycle do |instruction|
      next_node = @nodes[current_node][instruction]
      @steps += 1
      current_node = next_node
      break if current_node[-1] == 'Z'
    end
    @steps
  end

  def send_ghosts
    @step_counts = []
    starting_nodes = @nodes.keys.select { |key| key[-1] == 'A' }
    starting_nodes.each do |starting_node|
      @step_counts << count_steps_from(starting_node)
    end
  end

  def calc_ghosts
    @step_counts.reduce(1, :lcm)
  end

  def part_one
    puts count_steps_from('AAA')
  end

  def part_two
    send_ghosts
    puts calc_ghosts
  end
end

day_eight = DayEight.new
puts '--- Part 1 ---'
puts day_eight.part_one
puts '--- Part 2 ---'
puts day_eight.part_two
