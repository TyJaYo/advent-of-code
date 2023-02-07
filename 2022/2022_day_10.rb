#!/usr/bin/env ruby
PATH = './inputs/day_10.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT
INTERESTING_CYCLES = [20, 60, 100, 140, 180, 220]

class SigCycl
  def initialize
    @instructions = []
    @cycles = {0 => 1}
    @addends = 0
  end

  def run
    process_instructions
    follow_instructions
    report
    print_screen
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

  def calculate_interest(cycles = INTERESTING_CYCLES)
    grand_total = 0
    cycles.each do |ic|
      total = calculate_x(ic)
      grand_total += total * ic
    end
    grand_total
  end 

  def calculate_x(ic)
    total = 0
    for cycle in 0..ic do 
      total += @cycles[cycle] if @cycles[cycle]
    end
    total
  end

  def report
    p "The interesting signal strengths total #{calculate_interest}."
  end

  def print_screen
    Array(1..240).each_slice(40) do |row|
      print_row(row)
      print "\n"
    end
  end

  def print_row(row)
    row.each_with_index do |cycle, i|
      print lit?(cycle, i) ? '#' : ' '
    end
  end

  def lit?(cycle, i)
    sprite = Array(i - 1..i + 1)
    x = calculate_x(cycle)
    sprite.include?(x) ? true : false
  end
end

puts '--- Day 10: Cathode-Ray Tube ---'
sc = SigCycl.new
sc.run
