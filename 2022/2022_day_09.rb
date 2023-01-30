#!/usr/bin/env ruby
PATH = './inputs/day_08.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class TreeSee
  def initialize
    @instructions = INPUT.map(&:split)
    @head_loc = 0
    @tail_loc = 0
    @tail_locs = []
  end

  def run
    follow_instructions
    report
  end

  def follow_instructions
    INPUT.each do |line|
    end
  end

  def mark_place(x, y)
    @tail_locs << [x, y]
  end

  def report
    p "The tail visited #{@tail_locs.uniq.count} places."
    p "#{@instructions}"
  end
end

puts '--- Day 9: Rope Bridge ---'
rr = RopeRunnr.new
rr.run
