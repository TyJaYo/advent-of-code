#!/usr/bin/env ruby
puts "--- Day 8: Handheld Halting ---"
puts "--- Part 0: Parse Input ---"
PATH = './inputs/day-08.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INPUT

puts "--- Part 1: Run Until Repeat ---"
indices =*(0...INPUT.size)
instructions = INPUT.map(&:split)
accumulator = 0
next_step = 0

while indices.include?(next_step)
  step = indices.delete(next_step)
  puts step
  op, num = instructions[step].first, instructions[step].last.to_i
  case op
  when "acc"
    accumulator += num
    next_step += 1
  when "jmp"
    next_step = step + num
  when "nop"
    next_step += 1
  end
end

puts "\nWhat value is in the accumulator?"
puts accumulator
