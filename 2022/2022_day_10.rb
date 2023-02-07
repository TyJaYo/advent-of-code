#!/usr/bin/env ruby
PATH = './inputs/day_10.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT
INTERESTING_CYCLES = [20, 60, 100, 140, 180, 220]

class SigCycl
  def initialize
    @instructions = []
    @cycles = {0 => 1}
    @interesting = []
    @addends = 0
  end

  def run
    process_instructions
    follow_instructions
    report
  end

  def process_instructions
    @instructions = INPUT.map(&:split)
                         .map { |e| e[1] = e.last.to_i; e }
  end

  def follow_instructions
    @instructions.each_with_index do |line, i|
      instruction, addend = line
      addx(addend, i) if instruction == 'addx'
    end
  end

  def addx(addend, i)
    @addends += 1
    @cycles[i + 2 + @addends] = addend
  end

  def calculate_interest
    grand_total = 0
    INTERESTING_CYCLES.each do |ic|
      total = 0
      for cycle in 0..ic do 
        total += @cycles[cycle] if @cycles[cycle]
      end
      grand_total += total * ic
    end
    grand_total
  end 

  def report
    p "The interesting signal strengths total #{calculate_interest}."
  end
end

puts '--- Day 10: Cathode-Ray Tube ---'
sc = SigCycl.new
sc.run
