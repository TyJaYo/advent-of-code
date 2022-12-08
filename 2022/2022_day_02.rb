#!/usr/bin/env ruby
puts '--- Day 2: Rock Paper Scissors ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_02.txt'.freeze
INPUT = File.open(PATH).readlines.map { |l| l.split("\n") }.map { |l| l.first.split }.freeze
puts "Successfully read input from #{PATH}" if INPUT

puts '--- Part 1: Find points for strat ---'
class Game
  def initialize
    @points = 0
    @winner = ''
    @loser = ''
    @drawer = ''
  end

  def run
    INPUT.each do |line|
      play(line)
    end
    report
  end

  def play(line)
    opponent_play = line.first
    own_play = line.last
    case opponent_play
    when 'A'
      @winner = 'Y'
      @loser = 'Z'
      @drawer = 'X'
    when 'B'
      @winner = 'Z'
      @loser = 'X'
      @drawer = 'Y'
    when 'C'
      @winner = 'X'
      @loser = 'Y'
      @drawer = 'Z'
    end
    case own_play
    when 'X'
      @points += 1
    when 'Y'
      @points += 2
    when 'Z'
      @points += 3
    end
    @points += 0 if own_play == @loser
    @points += 3 if own_play == @drawer
    @points += 6 if own_play == @winner
  end

  def report
    puts @points
  end
end

g = Game.new
g.run

puts '--- Part 2: A new strat ---'
class Game2
  def initialize
    @points = 0
    @winner = 0
    @loser = 0
    @drawer = 0
  end

  def run
    INPUT.each do |line|
      play(line)
    end
    report
  end

  def play(line)
    opponent_play = line.first
    own_play = line.last
    case opponent_play
    when 'A'
      @winner = 2
      @loser = 3
      @drawer = 1
    when 'B'
      @winner = 3
      @loser = 1
      @drawer = 2
    when 'C'
      @winner = 1
      @loser = 2
      @drawer = 3
    end
    case own_play
    when 'X'
      @points += 0 + @loser
    when 'Y'
      @points += 3 + @drawer
    when 'Z'
      @points += 6 + @winner
    end
  end

  def report
    puts @points
  end
end

g2 = Game2.new
g2.run
