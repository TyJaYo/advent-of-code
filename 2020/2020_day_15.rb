# !/usr/bin/env ruby
# frozen_string_literal: true

puts '--- Day 15: Rambunctious Recitation ---'
puts '--- Part 1: Play to 2020 ---'

INPUT = [15, 12, 0, 14, 3, 1].freeze
TURN_LIMIT = 2020

# Class for solving Part 1
class Game
  attr_accessor :record

  def initialize
    @record = INPUT.dup
  end

  def run
    play_a_round until record.size == TURN_LIMIT
    print_output
  end

  def play_a_round
    last_said = find_indices_of(record.last).last(2)
    record << if last_said.size > 1
                last_said.last - last_said.first
              else
                0
              end
  end

  def find_indices_of(number)
    record.each_index.select { |i| record[i] == number }
  end

  def print_output
    puts "Given the starting numbers #{INPUT}, "
    puts "the #{TURN_LIMIT}th number spoken is #{@record.last}."
  end
end

g = Game.new
g.run
