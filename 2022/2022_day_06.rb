#!/usr/bin/env ruby
PATH = './inputs/day_06.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class PacktSniffr
  def initialize
    @count = 0
    @last_four = []
  end

  def run
    process_input
    report
  end

  def process_input
    INPUT.first.chars do |char|
      @count += 1
      @last_four << char
      @last_four.shift if @last_four.size > 4
      break if @last_four.uniq.size == 4
    end
  end

  def report
    puts @count
  end
end

puts '--- Day 6: Tuning Trouble ---'
puts '--- Part 1 ---'
ps = PacktSniffr.new
ps.run

puts '--- Part 2 ---'

class MsgSniffr
  def initialize
    @count = 0
    @last_fourteen = []
  end

  def run
    process_input
    report
  end

  def process_input
    INPUT.first.chars do |char|
      @count += 1
      @last_fourteen << char
      @last_fourteen.shift if @last_fourteen.size > 14
      break if @last_fourteen.uniq.size == 14
    end
  end

  def report
    puts @count
  end
end

ms = MsgSniffr.new
ms.run
