#!/usr/bin/env ruby
puts '--- Day 4: Camp Cleanup ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_04.txt'.freeze
INPUT = File.open(PATH).readlines.map { |l| l.split("\n") }.map { |l| l.first.split(',') }.map { |l| l.map { |l| l.split('-') } }.map { |l| l.map { |l| l.map(&:to_i) } }.freeze
puts "Successfully read input from #{PATH}" if INPUT

class AssignmentAnalyzer
  def initialize
    @contains = 0
    @overlaps = 0
  end

  def run
    INPUT.each do |line|
      analyze(line)
    end
    report
  end

  def analyze(line)
    first_min, first_max = line[0][0], line[0][1]
    second_min, second_max = line[1][0], line[1][1]
    if (first_min >= second_min && first_max <= second_max) || (second_min >= first_min && second_max <= first_max)
      @contains += 1
    end
    if (first_min <= second_max && first_max >= second_min) || (second_min <= first_max && second_max >= first_min)
      @overlaps += 1
    end
  end

  def report
    puts '--- Part 1: In how many assignment pairs does one range fully contain the other? ---'
    puts @contains
    puts '--- Part 2: In how many assignment pairs do the ranges overlap? ---'
    puts @overlaps
  end
end

aa = AssignmentAnalyzer.new
aa.run
