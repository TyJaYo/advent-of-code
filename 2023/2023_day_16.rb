#!/usr/bin/env ruby
require 'colorize'
INPUT_PATH = './inputs/day_16.txt'
INPUT = File.readlines(INPUT_PATH, chomp: true)
DIRS = {
  'n' => [0, 1],
  'e' => [-1, 0],
  's' => [0, -1],
  'w' => [1, 0]
}
XMAX = INPUT[0].chars.size - 1
YMAX = INPUT.size - 1

class Square
  attr_reader :x, :y, :char
  attr_accessor :entries
  def initialize(char)
    @char    = char
    @entries = []
  end

  def get_hit_from(from)
    return nil if @entries.include?(from)

    @entries << from
    return [from] if @char == '.'

    case [from, @char]
    when ['n', '\\'] then return ['w']
    when ['e', '\\'] then return ['s']
    when ['s', '\\'] then return ['e']
    when ['w', '\\'] then return ['n']
    when ['n', '|'] then return ['n']
    when ['e', '|'] then return ['n','s']
    when ['s', '|'] then return ['s']
    when ['w', '|'] then return ['n','s']
    when ['n', '/'] then return ['e']
    when ['e', '/'] then return ['n']
    when ['s', '/'] then return ['w']
    when ['w', '/'] then return ['s']
    when ['n', '-'] then return ['e','w']
    when ['e', '-'] then return ['e']
    when ['s', '-'] then return ['e','w']
    when ['w', '-'] then return ['w']
    end
  end
end

class Beam
attr_accessor :x, :y, :from
  def initialize(x, y, from)
    @x    = x
    @y    = y
    @from = from
  end

  def lase
    xy_offsets = DIRS[@from]
    @x += @xy_offsets[0]
    @y += @xy_offsets[1]
  end
end

class DaySixteen
  def initialize
    @squares = Hash.new { |h,k| h[k] = {} }
    @beams   = []
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, y_dx|
      line.chars.each_with_index do |char, x_dx|
        @squares[x_dx][y_dx] = Square.new(char)
      end
    end
  end

  def charge_laser
    @beams << Beam.new(0, 0, 'w')
  end

  def lasers_lase
    @beams.each do |beam|
      beam.lase
    end
  end

  def lasers_check
    @beams.each do |beam|
      x = beam.x
      y = beam.y
      result = @squares[x][y]&.get_hit_from(beam.from)

      if result.nil?
        puts @beams.inspect
        beam.delete
        puts @beams.inspect
        break
      end

      if result[1]
        @beams << Beam.new(x, y, result[1])
      end

      beam.from = result[0]
    end
  end

  def print_map
    print "\n"
    (0..YMAX).each do |r|
      (0..XMAX).each do |c|
        square = @squares[c][r]
        case square.entries
        when []
          print square.char
        when ['n'] then print 'v'.red
        when ['e'] then print '<'.red
        when ['s'] then print '^'.red
        when ['w'] then print '>'.red
        else print square.char.red
        end
      end
      print "\n"
    end
  end

  def part_one
    charge_laser
    until @beams.empty?
      lasers_check
      lasers_lase
      print_map
    end
    energized = @squares.sum do |square|
      square.entries.empty? ? 0 : 1
    end
    puts energized
  end

  def part_two
  end
end

puts '--- Day 16 ---'
day_sixteen = DaySixteen.new
puts '--- Part 1 ---'
day_sixteen.part_one
puts '--- Part 2 ---'
day_sixteen.part_two
