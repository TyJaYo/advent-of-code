#!/usr/bin/env ruby

puts "--- Day 12: Rain Risk ---"
puts "--- Part 0: Parse Input ---"

PATH = './inputs/day-12.txt'
INSTRUCTIONS = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INSTRUCTIONS

puts "--- Part 1: Take directions ---"
class Navigator
  def initialize
  end

  def run
  end
end

n = Navigator.new
n.run
