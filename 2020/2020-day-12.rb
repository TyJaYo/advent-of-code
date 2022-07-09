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
    @heading = @heading - 360 while @heading >= 360
  end

  def dy(n)
    @y += n
  end

  def dx(n)
    @x += n
  end

  def dh(n)
    @heading += n
  end

  def output_manhattan
    puts "What is the Manhattan distance between that location and the ship's starting position?"
    puts  "|#{@x}| + |#{@y}| = #{@x.abs} + #{@y.abs} = #{@x.abs + @y.abs}"
  end
end

n = NavigatorP1.new
n.run

puts "--- Part 2: Move waypoint ---"
class NavigatorP2
  def initialize
    @sx = 0
    @wx = 10
    @sy = 0
    @wy = 1
    @qs = ["I","II","III","IV"]
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

  def dy(n)
    @wy += n
  end

  def dx(n)
    @wx += n
  end

  def go(n)
    @sx += (@wx * n)
    @sy += (@wy * n)
  end

  def dh(n)
    cq = current_quadrant
    @qs.rotate! until @qs.first == cq
    turns = n / 90
    @qs.rotate!(-turns)
    set_quadrant(@qs.first)
  end

  def current_quadrant
    return "I" if @wx >= 0 && @wy >= 0
    return "II" if @wx <= 0 && @wy >= 0
    return "III" if @wx <= 0 && @wy <= 0
    return "IV" if @wx >= 0 && @wy <= 0
    puts "Could not determine current quadrant"
  end

  def set_quadrant(q)
    case q
    when "I"
      @wx = @wx.abs
      @wy = @wy.abs
    when "II"
      @wx = @wx.abs * -1
      @wy = @wy.abs
    when "III"
      @wx = @wx.abs * -1
      @wy = @wy.abs * -1
    when "IV"
      @wx = @wx.abs
      @wy = @wy.abs * -1
    else
      puts "Could not set quadrant"
    end
  end

  def output_manhattan
    puts "What is the Manhattan distance between that location and the ship's starting position?"
    puts  "|#{@sx}| + |#{@sy}| = #{@sx.abs} + #{@sy.abs} = #{@sx.abs + @sy.abs}"
  end
end

n = NavigatorP2.new
n.run
