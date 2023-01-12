#!/usr/bin/env ruby
PATH = './inputs/day_05.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class CargoStackr
  def initialize
    @yard_input = []
    @instructions = []
    @yard_hash = Hash.new { |hash, key| hash[key] = [] }
    process_input
    process_yard
  end

  def process_input
    INPUT.each do |line|
      nums = line.scan(/\s(\d+)/)
      case nums.size
      when 0
        @yard_input << line if line.chars.include?('[')
      when 3
        @instructions << nums.flatten.map(&:to_i)
      end
    end
  end

  def process_yard
    @yard_input.each do |line|
      (0...line.length).step(4).with_index do |n, i|
        letter = line[n + 1]
        @yard_hash[i + 1] << letter unless letter.match?(/\s/)
      end
    end
  end

  def run_instructions
    @instructions.each do |instruction|
      quantity = instruction[0]
      origin   = instruction[1]
      target   = instruction[2]

      quantity.times do
        @yard_hash[target].prepend(@yard_hash[origin].shift)
      end
    end
  end

  def report
    report_string = ''
    9.times do |t|
      report_string << @yard_hash[t + 1].first
    end
    puts report_string
  end
end

puts '--- Day 5: Supply Stacks ---'
cs = CargoStackr.new
cs.run_instructions
cs.report
