#!/usr/bin/env ruby

puts "--- Day 4: Passport Processing ---"

puts "--- Part 0: Parse Input ---"
# PATH = './inputs/day-04-example.txt'
PATH = './inputs/day-04.txt'
INPUT = File.read(PATH).freeze
puts "Successfully read input from #{PATH}" if INPUT.size > 0

passports = INPUT.gsub("\n",' ').split('  ').map { |x| x.split }.map { |x| Hash[x.map { |x| x.split(':') }] }

puts "--- Part 1: Count Passports with All Required Fields ---"
REQ_FIELDS = %w[byr iyr eyr hgt hcl ecl pid]

pps_with_all_req_fields = passports.filter { |pp| REQ_FIELDS.all? { |k| pp.key?(k) } }

puts "I count #{pps_with_all_req_fields.count} passports with all required fields."

puts "--- Part 2: Count Fully Valid ---"
LEGIT_ECLS = %w[amb blu brn gry grn hzl oth]

def valid?(k,v)
  case k
  when "byr" then v.to_i.between?(1920,2002)
  when "iyr" then v.to_i.between?(2010,2020)
  when "eyr" then v.to_i.between?(2020,2030)
  when "hgt"
    num, u = v.match(/(\d+)(cm|in)/)&.captures
    (u == "cm" && num.to_i.between?(150,193)) || (u == "in" && num.to_i.between?(59,76))
  when "hcl" then v.match?(/^#[\da-f]{6}$/)
  when "ecl" then LEGIT_ECLS.any? { |ecl| ecl == v }
  when "pid" then v.match?(/^\d{9}$/)
  end
end

pps_with_all_req_fields_valid = pps_with_all_req_fields.filter { |pp|
  REQ_FIELDS.all? { |f| valid?(f,pp[f]) }
}

puts "I count #{pps_with_all_req_fields_valid.count} passports with all required fields valid."
