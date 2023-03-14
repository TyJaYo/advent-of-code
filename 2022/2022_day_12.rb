#!/usr/bin/env ruby
puts '--- Day 12: Hill Climbing Algorithm ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_12.txt'.freeze
INPUT = File.open(PATH).readlines.map{ |l| l.split("\n\n") }.map{ |l| l.split("\n") }.map(&:to_i).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts '--- Part 1: Find shortest path ---'
class PathFinder
  def initialize
    @elves = separate(INPUT.dup)
  end

  def find_shortest
  end
end

pf = PathFinder.new
puts pf.find_shortest
puts '--- Part 2: ---'
