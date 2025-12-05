#!/usr/bin/env ruby
puts '--- Day 1 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_01.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayOne
  def initialize
    @dial = (0..99).to_a
    initial_position = 50
    @instructions = [["R", initial_position]]
    @zero_hits = 0
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      @instructions << [line[0], line[1..-1].to_i]
    end
  end

  def part_one
    run_instructions(@dial, @instructions)
    show(@zero_hits)
  end

  def run_instructions(dial, instructions)
    instructions.each do |direction, steps|
      if direction == "R"
        dial.rotate!(steps)
      else
        dial.rotate!(-steps)
      end
      @zero_hits += 1 if dial[0] == 0
    end
  end

  def part_two
    run_method_0x434C49434B
    show(@zero_hits)
  end

  def run_method_0x434C49434B
    @instructions.each do |direction, steps|
      if direction == "R"
        steps.times do
          @dial.rotate!(1)
          @zero_hits += 1 if @dial[0] == 0
        end
      else
        steps.times do
          @dial.rotate!(-1)
          @zero_hits += 1 if @dial[0] == 0
        end
      end
    end
  end

  def show(number)
    puts @zero_hits
    system("echo #{@zero_hits} | pbcopy")
    puts 'Copied to clipboard'
  end
end

day_one = DayOne.new
puts '--- Part 1 ---'
day_one.part_one

day_one = DayOne.new
puts '--- Part 2 ---'
day_one.part_two
