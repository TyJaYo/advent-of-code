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
    @bus_indices = []
  end

  def run
    parse_input
    check_times
    report
  end

  def parse_input
    @buses = @input.last.split(',')
    @bus_indices = @buses.each_index.select{|i| @buses[i] != 'x'}
    @buses.map!(&:to_i)
  end

  def check_times
    biggest, big_dex = @buses.each_with_index.max
    check = 0
    while true
      check += biggest
      print "#{check} "
      if @bus_indices.all? { |bx| check - big_dex + bx % @buses[bx] == 0 }
        puts check - big_dex
        break
      end
    end
  end

  def report
    puts "What is the earliest timestamp such that all of the listed bus IDs depart
    at offsets matching their positions in the list?"
  end
end

tf = TFinder.new
tf.run
