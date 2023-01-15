#!/usr/bin/env ruby
PATH = './inputs/day_07.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class DrivMappr
  def initialize
  end

  def run
    process_input
    report
  end

  def process_input
  end

  def report
    puts INPUT
  end
end

puts '--- Day 7: No Space Left On Device ---'
puts '--- Part 1 ---'
dm = DrivMappr.new
dm.run

puts '--- Part 2 ---'
dm2 = DrivMappr.new
dm2.run
