#!/usr/bin/env ruby

puts "--- Day 13: Shuttle Search ---"
puts "--- Part 0: Parse Input ---"

PATH = './inputs/day-13.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts "--- Part 1: Find bus closest to earliest departure ---"
class BusFinder
  def initialize
    @input = INPUT.dup
    @earliest = 0
    @buses = []
    @bus_waits = []
    @winner = 0
    @winning_wait = 0
  end

  def run
    parse_input
    calculate_times
    determine_winner
    report
  end

  def parse_input
    @earliest = @input.first.to_i
    @buses = @input.last.split(',').reject { |x| x == 'x' }.map(&:to_i)
  end

  def calculate_times
    @buses.each do |bus|
      etd = bus
      until etd >= @earliest
        etd += bus
      end
      wait = etd - @earliest
      @bus_waits << [wait, bus]
    end
  end

  def determine_winner
    @bus_waits.sort!
    @winning_wait, @winner = @bus_waits[0][0], @bus_waits[0][1]
  end

  def report
    puts "What is the ID of the earliest bus you can take to the airport multiplied
    by the number of minutes you'll need to wait for that bus?"
    puts  "#{@winner} ⨉ #{@winning_wait} = #{@winner * @winning_wait}"
  end
end

bf = BusFinder.new
bf.run
