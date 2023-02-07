#!/usr/bin/env ruby
PATH = './inputs/day_10.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class MonkyChasr
  def initialize
    @starting_props = []
  end

  def run
    process_input
    make_monkeys
    watch_monkeys
    report
  end

  def process_input
  end

  def make_monkeys
  end

  def watch_monkeys
  end

  def report
  end
end

puts '--- Day 11: Monkey in the Middle ---'
mc = MonkyChasr.new
mc.run
