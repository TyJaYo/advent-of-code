#!/usr/bin/env ruby
require "pry"

puts "--- Day 11: Seating System ---"
puts "--- Part 0: Parse Input ---"

# PATH = './inputs/day-11.txt'
PATH = './inputs/day-11-example.txt'
MATRIX = File.open(PATH).readlines.map(&:chomp).map(&:chars).freeze
puts "Successfully read input from #{PATH}" if MATRIX

ROWSIZE = MATRIX.first.length
COLSIZE = MATRIX.length

puts "--- Part 1: Simulate Life until it doesn't change ---"
class SeatMapper
  def initialize
    @mapped_matrix = {}
    COLSIZE.times do |ct|
      ROWSIZE.times do |rt|
        @mapped_matrix[[ct,rt]] = MATRIX[ct][rt]
      end
    end

    @change = false
    @step_counter = 0
  end

  def run
    binding.pry
  end
end

sm = SeatMapper.new
sm.run
