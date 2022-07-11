#!/usr/bin/env ruby

puts "--- Day 13: Shuttle Search ---"
puts "--- Part 0: Parse Input ---"

PATH = './inputs/day-12.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts "--- Part 1: Find bus closest to earliest departure ---"
class BusFinder
  def initialize
    @input = INPUT.dup
    @earliest = 0
    @winner = 0
    @wait = 0
    @buses = []
  end

  def run
    parse_input
    calculate_winner
    report
  end

  def parse_input
    @earliest = @input.first.to_i
    @buses = @input.last.split(',').reject { |x| x == 'x' }.map(&:to_i)
    puts @buses.inspect
  end

  def calculate_winner

  end

  def report
    puts "What is the ID of the earliest bus you can take to the airport multiplied
    by the number of minutes you'll need to wait for that bus?"
    puts  "#{@winner} ⨉ #{@wait} = #{@winner * @wait}"
  end
end

bf = BusFinder.new
bf.run
