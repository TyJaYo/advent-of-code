#!/usr/bin/env ruby

puts "--- Day 13: Shuttle Search ---"
puts "--- Part 0: Parse Input ---"

PATH = './inputs/day-13.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts "--- Part 2: Find time departures align ---"
class TFinder
  def initialize
    @input = INPUT.dup
    @t = 0
    @buses = []
  end

  def run
    parse_input
    find_biggest
    check_times
    report
  end

  def parse_input
    @input = @input.last.gsub('x','1')
    @buses = @input.split(',').map(&:to_i)
    puts @buses.inspect
  end

  def find_biggest
    @buses.each_with_index.max[1]
  end

  def check_times
  end

  def report
    puts "What is the earliest timestamp such that all of the listed bus IDs depart
    at offsets matching their positions in the list?"
  end
end

tf = TFinder.new
tf.run
