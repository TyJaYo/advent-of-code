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
    @shh = true
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
      when "N" then go_N(number)
      when "S" then go_S(number)
      when "E" then go_E(number)
      when "W" then go_W(number)
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
        when 0 then go_N(number)
        when 90 then go_E(number)
        when 180 then go_S(number)
        when 270 then go_W(number)
        else puts "WARNING -- TRIGONOMETRY DETECTED"
        end
      end
      say("\n")
    end
  end

  def reorient
    say("translated #{@heading}º to ")
    @heading = 360 - @heading.abs if @heading < 0
    @heading = @heading.abs - 360 while @heading.abs >= 360
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
    puts "What is the Manhattan distance between that location and the ship's starting position?"
    puts  "|#{@x}| + |#{@y}| = #{@x.abs} + #{@y.abs} = #{@x.abs + @y.abs}"
  end

  def say(str)
    print(str) unless @shh
  end
end

n = NavigatorP1.new
n.run

puts "--- Part 2: Move waypoint ---"
class NavigatorP2
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
      when "N" then go_N(number)
      when "S" then go_S(number)
      when "E" then go_E(number)
      when "W" then go_W(number)
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
        when 0 then go_N(number)
        when 90 then go_E(number)
        when 180 then go_S(number)
        when 270 then go_W(number)
        else puts "WARNING -- TRIGONOMETRY DETECTED"
        end
      end
      say("\n")
    end
  end

  def reorient
    say("translated #{@heading}º to ")
    @heading = 360 - @heading.abs if @heading < 0
    @heading = @heading.abs - 360 while @heading.abs >= 360
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

n = NavigatorP2.new
n.run

