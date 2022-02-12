#!/usr/bin/env ruby

puts "--- Day 4: Passport Processing ---"

puts "--- Part 0: Parse Input ---"
# PATH = './inputs/day-04-example.txt'
PATH = './inputs/day-04.txt'
INPUT = File.read(PATH).freeze
puts "Successfully read input from #{PATH}" if INPUT.size > 0

passports = INPUT.gsub("\n",' ').split('  ').map { |x| x.split }.map { |x| Hash[x.map { |x| x.split(':') }] }

puts "--- Part 1: Count Valid by Field Presence ---"
REQ_FIELDS = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]

valid_count = passports.count { |pp| REQ_FIELDS.all? { |k| pp.key?(k) } }

puts "I count #{valid_count} valid passports."

# --- Part Two ---
