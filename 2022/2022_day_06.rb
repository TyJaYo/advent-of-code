#!/usr/bin/env ruby
PATH = './inputs/day_06.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class PacktSniffr
  def initialize
  end

  def process_input
    INPUT.each do |line|
      nums = line.scan(/\s(\d+)/)
      case nums.size
      when 0
        @yard_input << line if line.chars.include?('[')
      when 3
        @instructions << nums.flatten.map(&:to_i)
      end
    end
  end

  def report
    report_string = ''
    9.times do |t|
      report_string << @yard_hash[t + 1].first
    end
    puts report_string
  end
end

puts '--- Day 6: Tuning Trouble ---'
puts '--- Part 1 ---'
ps = PacktSniffr.new
ps.run
ps.report

puts '--- Part 2 ---'
