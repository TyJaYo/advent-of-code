#!/usr/bin/env ruby

puts "--- Day 5: Binary Boarding ---"

puts "--- Part 0: Parse Input ---"
PATH = './inputs/day-05.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).freeze

puts "Successfully read input from #{PATH}" if INPUT

puts "--- Part 1: Find Highest Seat ID ---"

ROWS = (0..127)
COLS = (0..7)

def find_seat(sbin="BBFFBBFRLL".chars) # assumption: will recieve array
  robary = sbin.shift(7) # assumption: array will start with 7 F/R chars
  cobary = sbin # assumption: removing those 7 chars will leave 3 L/R chars
  found_row = find("row",robary)
  found_col = find("col",cobary)
  seat_id = (found_row * 8) + found_col
end

def find(param,ary)
  case param
  when "row"
    range = ROWS
    upper, lower = "B", "F"
  when "col" then range = COLS
    range = COLS
    upper, lower = "R", "L"
  end
  max = range.max
  min = range.min
  until range.size == 1
    mid = (max + min)/2
    dir = ary.shift
    case dir
    when upper then min = mid + 1
    when lower then max = mid
    end
    range = (min..max)
  end
  range.max
end

sids = []
INPUT.each do |pass|
  sids << find_seat(pass.chars)
end

puts "The highest Seat ID scanned was #{sids.max}."

