# !/usr/bin/env ruby
# frozen_string_literal: true

require "pry"

puts '--- Day 15: Rambunctious Recitation ---'
puts '--- Part 1: Play to 2020 ---'

INPUT = [0,3,6].freeze
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
    puts "the #{TURN_LIMIT}th number spoken is #{record.last}."
  end
end

g = Game.new
g.run

puts '--- Part 2: Play to 30,000,000 ---'
# TURN_LIMIT2 = 30_000_000
TURN_LIMIT2 = 10

# Class for solving Part 2
class Game2
  attr_accessor :record
  def initialize
    @record = {}
  end

  def run
    play_from_hash
    play_rounds
    print_output
  end

  def play_from_hash
    INPUT.size.times do |t|
      record[INPUT[t]] = [t + 1]
    end
    puts record
  end

  def play_rounds
    starting_size = INPUT.size
    (TURN_LIMIT2 - starting_size).times do |t|
      prev_turn = t + starting_size
      curr_turn = prev_turn + 1
      prev_val = record.key(prev_turn)
      puts "prev_turn = #{prev_turn}"
      puts "curr_turn = #{curr_turn}"
      puts "prev_val = #{prev_val}"
      if record[prev_val]
        diff = prev_turn - record[prev_val]
        record[diff] << curr_turn
        # puts "#{diff} = #{prev_turn} - #{record[prev_val]}"
        # puts "#{diff = prev_turn - record[prev_val]}"
      else
        record[0] << curr_turn
      end
      puts record.inspect
    end
  end

  def print_output
    last_turn_entry = record.max_by{ |x| x.last.last }
    puts "Given the starting numbers #{INPUT}, "
    puts "the #{last_turn_entry.last.last}th number spoken is #{last_turn_entry.first}."
  end
end

g2 = Game2.new
g2.run
