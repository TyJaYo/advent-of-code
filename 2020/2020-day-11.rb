#!/usr/bin/env ruby
require "pry"

puts "--- Day 11: Seating System ---"
puts "--- Part 0: Parse Input ---"
# PATH = './inputs/day-11.txt'
PATH = './inputs/day-11-example.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).map(&:chars).freeze
puts "Successfully read input from #{PATH}" if INPUT
SLEEPYTIME = 0.07
CSI = "\e["

puts "--- Part 1: Simulate Life until changes cease ---"
class SeatMapper
  def initialize
    @map = INPUT.dup
    @change = false
  end

  def run
    show_map(1)
    binding.pry
  end

  def show_map(t)
    $stdout.write "#{CSI}2J"    # clear screen
    $stdout.write "#{CSI}1;1H"  # move to top left corner
    @map.each do |row|
      row.each do |char|
        $stdout.print char
      end
      $stdout.print "\n"
    end
    puts "After #{t} steps..."
    sleep(SLEEPYTIME)
  end
end

sm = SeatMapper.new
sm.run
