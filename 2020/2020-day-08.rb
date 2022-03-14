#!/usr/bin/env ruby
puts "--- Day 8: Handheld Halting ---"
puts "--- Part 0: Parse Input ---"
PATH = './inputs/day-08.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts "--- Part 1: Run Until Repeat ---"
class Booter
  def initialize
    @indices =*(0...INPUT.size)
    @instructions = INPUT.map(&:split)
    @accumulator = 0
    @next_step = 0
    @last_step = @instructions.last.index
  end
  def boot(opt = 1)
    while @indices.include?(@next_step)
      step = @indices.delete(@next_step)
      op, num = @instructions[step].first, @instructions[step].last.to_i
      case op
      when "acc"
        @accumulator += num
        @next_step += 1
      when "jmp"
        @next_step = step + num
      when "nop"
        @next_step += 1
      end
    end
    return false unless opt == 1 || @next_step == @last_step
    @accumulator
  end
  def switch_fix
    @instructions.each do |instruction|
      inst = instruction.first
      if inst == "nop" || inst == "jmp"
        case inst
        when "nop" then instruction[0] = "jmp"
        when "jmp" then instruction[0] = "nop"
        end
        unless boot(2)
          switch_fix
        end
        @accumulator
      end
    end
  end
end

part_one = Booter.new

puts "What value is in the accumulator?"
puts part_one.boot

puts "--- Part 2: Fix Infinite Loop ---"
part_two = Booter.new

puts "What is the value of the accumulator after the program terminates?"
puts part_one.switch_fix
