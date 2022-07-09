#!/usr/bin/env ruby

puts "--- Day 12: Rain Risk ---"
puts "--- Part 0: Parse Input ---"

PATH = './inputs/day-12.txt'
INSTRUCTIONS = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INSTRUCTIONS

puts "--- Part 1: Take directions ---"
class NavigatorP1
  def initialize
    @heading = 90 # east
    @x = 0
    @y = 0
  end

  def run
    follow_directions
    output_manhattan
  end

  def follow_directions
    INSTRUCTIONS.each do |i|
      letter = i.slice! 0
      number = i.to_i
      case letter
      when "N" then dy(number)
      when "E" then dx(number)
      when "S" then dy(-number)
      when "W" then dx(-number)
      when "R" then dh(number)
      when "L" then dh(-number)
      when "F" then go(number)
      end
    end
  end

  def go(n)
    reorient unless @heading.between?(0,359)
    case @heading
    when 0 then dy(n)
    when 90 then dx(n)
    when 180 then dy(-n)
    when 270 then dx(-n)
    end
  end

  def reorient
    @heading = 360 - @heading.abs while @heading < 0
    @heading = @heading.abs - 360 while @heading.abs >= 360
  end

  def dy(n)
    @y = @y + n
  end

  def dx(n)
    @x = @x + n
  end

  def dh(n)
    @heading = @heading + n
  end

  def output_manhattan
    puts "What is the Manhattan distance between that location and the ship's starting position?"
    puts  "|#{@x}| + |#{@y}| = #{@x.abs} + #{@y.abs} = #{@x.abs + @y.abs}"
  end
end

n = NavigatorP1.new
n.run
