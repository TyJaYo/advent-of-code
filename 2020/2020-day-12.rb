#!/usr/bin/env ruby

puts "--- Day 12: Rain Risk ---"
puts "--- Part 0: Parse Input ---"

PATH = './inputs/day-12.txt'
INSTRUCTIONS = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INSTRUCTIONS

puts "--- Part 1: Take directions ---"
class Navigator
  def initialize
    @heading = 90 # east
    @x = 0
    @y = 0
    @shh = false
  end

  def run
    follow_directions
    output_manhattan
  end

  def follow_directions
    INSTRUCTIONS.each do |i|
      letter = i.slice! 0
      number = i.to_i
      say("I read #{letter}#{number} so I ")
      case letter
      when "N"
        go_N(number)
      when "S"
        go_S(number)
      when "E"
        go_E(number)
      when "W"
        go_W(number)
      when "L"
        say("turned #{number}º from #{@heading}º ")
        @heading = @heading - number
        say("to #{@heading}º.")
      when "R"
        say("turned #{number}º from #{@heading}º ")
        @heading = @heading + number
        say("to #{@heading}º.")
      when "F"
        reorient unless @heading.between?(0,359)
        say("went forward on my heading #{@heading}º, i.e. ")
        case @heading
        when 0
          go_N(number)
        when 90
          go_E(number)
        when 180
          go_S(number)
        when 270
          go_W(number)
        else
          puts "WARNING -- TRIGONOMETRY DETECTED"
        end
      end
      say("\n")
    end
  end

  def reorient
    say("translated #{@heading}º to ")
    if @heading < 0
      @heading = 360 - @heading.abs
    end
    while @heading.abs >= 360
      @heading = @heading.abs - 360
    end
    say("#{@heading}º and then ")
  end

  def go_N(n)
    say("went from y = #{@y} ")
    @y = @y + n
    say("to y = #{@y}.")
  end

  def go_S(n)
    say("went from y = #{@y} ")
    @y = @y - n
    say("to y = #{@y}.")
  end

  def go_E(n)
    say("went from x = #{@x} ")
    @x = @x + n
    say("to x = #{@x}.")
  end

  def go_W(n)
    say("went from x = #{@x} ")
    @x = @x - n
    say("to x = #{@x}.")
  end

  def output_manhattan
    puts  "|#{@x}| + |#{@y}| = #{@x.abs} + #{@y.abs} = #{@x.abs + @y.abs}"
  end

  def say(str)
    print(str) unless @shh
  end
end

puts "What is the Manhattan distance between that location and the ship's starting position?"

n = Navigator.new
n.run

