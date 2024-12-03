#!/usr/bin/env ruby
puts '--- Day 3 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_03.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayThree
  def run_part(part)
    @instructions = []
    @results = []
    case part
      when 1 then regex = /(mul\(\d{1,3},\d{1,3}\))/
      when 2 then regex = /(don't\(\))|(do\(\))|(mul\(\d{1,3},\d{1,3}\))/
    end
    scan_for_instructions(regex)
    process_instructions
    tot(@results)
  end

  def scan_for_instructions(regex)
    INPUT.each do |line|
      @instructions += line.scan(regex).flatten.compact
    end
  end

  def process_instructions
    enabled = true
    @instructions.each do |instruction|
      if instruction.chars.first == 'm' && enabled
        a, b = instruction.scan(/\d+/).map(&:to_i)
        @results << a * b
      elsif instruction == 'don\'t()'
        enabled = false
      elsif instruction == 'do()'
        enabled = true
      end
    end
  end

  def tot(results)
    results_sum = results.sum
    puts results_sum
    system("echo #{results_sum} | pbcopy")
    puts 'Copied to clipboard!'
  end
end

day_three = DayThree.new
puts '--- Part 1 ---'
day_three.run_part(1)
puts '--- Part 2 ---'
day_three.run_part(2)
