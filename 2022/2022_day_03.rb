#!/usr/bin/env ruby
puts '--- Day 3: Rucksack Reorganization ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_03.txt'.freeze
INPUT = File.open(PATH).readlines.map { |l| l.split("\n") }.freeze
puts "Successfully read input from #{PATH}" if INPUT

puts '--- Part 1: Find sum of item priorities ---'
class RucksackParser
  def initialize
    @priority_map = PMap.new.zip
    @priority_sum = 0
  end

  def sack_check
    INPUT.each do |line|
      intersection = find_dupe(line).first
      add_value(intersection)
    end
    report
  end

  def badge_check
    threes = INPUT.each_slice(3).to_a
    threes.each do |triplet|
      intersection = triplet[0][0].chars & triplet[1][0].chars & triplet[2][0].chars
      add_value(intersection[0])
    end
    report
  end

  def add_value(letter)
    @priority_sum += @priority_map[letter]
  end

  def find_dupe(line)
    parts = mince(line)
    parts.first & parts.last
  end

  def mince(line)
    line.first.chars.each_slice(line.first.length / 2).to_a
  end

  def report
    puts @priority_sum
  end
end

class PMap
  def initialize
    @letters = [*('a'..'z'), *('A'..'Z')]
    @numbers = [*1..@letters.length]
  end

  def zip
    Hash[@letters.zip(@numbers)]
  end
end

rp = RucksackParser.new
rp.sack_check

puts '--- Part 2: Find sum of badge priorities ---'
rp2 = RucksackParser.new
rp2.badge_check
