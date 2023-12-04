#!/usr/bin/env ruby
puts '--- Day 4 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_04.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class DayFour
  def initialize
    @cards = {}
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      matches = line.match(/(\d+):(.*)\|(.*)/)
      id = matches[1].to_i
      winners = matches[2].split
      picks = matches[3].split
      @cards[id] = {match_count: (winners & picks).size, copies: 1}
    end
  end

  def award_points
    @cards.each do |id, data|
      if data[:match_count] > 0
        @cards[id][:points] = 2 ** (data[:match_count] - 1)
      end
    end
  end

  def award_copies
    @cards.each do |id, data|
      1.upto(data[:match_count]) do |t|
        @cards[id + t][:copies] += data[:copies]
      end
    end
  end

  def part_one
    award_points
    puts @cards.values.map { |data| data[:points] }.compact.sum
  end

  def part_two
    award_copies
    puts @cards.values.map { |data| data[:copies] }.compact.sum
  end
end

day_four = DayFour.new
puts '--- Part 1 ---'
puts day_four.part_one
puts '--- Part 2 ---'
puts day_four.part_two
