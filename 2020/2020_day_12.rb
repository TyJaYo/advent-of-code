# frozen_string_literal: true

# !/usr/bin/env ruby

puts '--- Day 12: Rain Risk ---'
puts '--- Part 0: Parse Input ---'

PATH = './inputs/day-12.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts '--- Part 1: Take directions ---'

# Class for solving Part 1
class NavigatorP1
  def initialize
    @instructions = INPUT.dup
    @heading = 90 # east
    @x = 0
    @y = 0
  end

  def run
    follow_directions
    output_manhattan
  end

  def follow_directions
    @instructions.each do |i|
      letter, number = i.match(/([A-Z])(\d+)/)&.captures
      number = number.to_i
      case letter
      when 'N' then add_to_y(number)
      when 'E' then add_to_x(number)
      when 'S' then add_to_y(-number)
      when 'W' then add_to_x(-number)
      when 'R' then add_to_heading(number)
      when 'L' then add_to_heading(-number)
      when 'F' then forward(number)
      end
    end
  end

  def forward(num)
    reorient unless @heading.between?(0, 359)
    case @heading
    when 0 then add_to_y(num)
    when 90 then add_to_x(num)
    when 180 then add_to_y(-num)
    when 270 then add_to_x(-num)
    end
  end

  def reorient
    @heading = 360 - @heading.abs while @heading.negative?
    @heading -= 360 while @heading >= 360
  end

  def add_to_y(num)
    @y += num
  end

  def add_to_x(num)
    @x += num
  end

  def add_to_heading(num)
    @heading += num
  end

  def output_manhattan
    puts "What is the Manhattan distance between that location and the ship's starting position?"
    puts "|#{@x}| + |#{@y}| = #{@x.abs} + #{@y.abs} = #{@x.abs + @y.abs}"
  end
end

n = NavigatorP1.new
n.run

puts '--- Part 2: Move waypoint ---'
# Class for solving Part 2
class NavigatorP2
  def initialize
    @instructions = INPUT.dup
    @ship_x = 0
    @waypoint_x = 10
    @ship_y = 0
    @waypoint_y = 1
    @quadrants = %w[I II III IV]
  end

  def run
    follow_directions
    output_manhattan
  end

  def follow_directions
    @instructions.each do |i|
      letter, number = i.match(/([A-Z])(\d+)/)&.captures
      number = number.to_i
      case letter
      when 'N' then add_to_y(number)
      when 'E' then add_to_x(number)
      when 'S' then add_to_y(-number)
      when 'W' then add_to_x(-number)
      when 'R' then add_to_heading(number)
      when 'L' then add_to_heading(-number)
      when 'F' then forward(number)
      end
    end
  end

  def add_to_y(num)
    @waypoint_y += num
  end

  def add_to_x(num)
    @waypoint_x += num
  end

  def forward(num)
    @ship_x += (@waypoint_x * num)
    @ship_y += (@waypoint_y * num)
  end

  def add_to_heading(num)
    cq = current_quadrant
    @quadrants.rotate! until @quadrants.first == cq
    turns = num / 90
    @quadrants.rotate!(-turns)
    @waypoint_x, @waypoint_y = @waypoint_y, @waypoint_x if turns.odd?
    update_quadrant(@quadrants.first)
  end

  def current_quadrant
    return 'I' if @waypoint_x >= 0 && @waypoint_y >= 0
    return 'II' if @waypoint_x <= 0 && @waypoint_y >= 0
    return 'III' if @waypoint_x <= 0 && @waypoint_y <= 0
    return 'IV' if @waypoint_x >= 0 && @waypoint_y <= 0
  end

  def update_quadrant(quadrant)
    case quadrant
    when 'I'
      @waypoint_x = @waypoint_x.abs
      @waypoint_y = @waypoint_y.abs
    when 'II'
      @waypoint_x = @waypoint_x.abs * -1
      @waypoint_y = @waypoint_y.abs
    when 'III'
      @waypoint_x = @waypoint_x.abs * -1
      @waypoint_y = @waypoint_y.abs * -1
    when 'IV'
      @waypoint_x = @waypoint_x.abs
      @waypoint_y = @waypoint_y.abs * -1
    end
  end

  def output_manhattan
    puts "What is the Manhattan distance between that location and the ship's starting position?"
    puts "|#{@ship_x}| + |#{@ship_y}| = #{@ship_x.abs} + #{@ship_y.abs} = #{@ship_x.abs + @ship_y.abs}"
  end
end

n2 = NavigatorP2.new
n2.run
