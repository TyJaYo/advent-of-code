#!/usr/bin/env ruby

puts "--- Day 6: Custom Customs ---"

puts "--- Part 0: Parse Input ---"
PATH = './inputs/day-06.txt'
INPUT = File.read(PATH).freeze
puts "Successfully read input from #{PATH}" if INPUT.size > 0

responses = INPUT.gsub("\n",' ').split('  ').map(&:split).map { |x| x.map(&:chars) }
# puts responses.inspect
# [[["f","i","r","s","t"]],[["i","n","d"],["s","i","b"]]]
# ^responses...    >    ^groups^  >  ^individuals^   ...^

puts "--- Part 1: Count Unique Yeses per Group ---"
grouped = responses.map(&:flatten)
uniques = grouped.map(&:uniq)
puts "For each group, count the number of questions to which anyone answered \"yes\"."
puts "What is the sum of those counts?"
puts uniques.map(&:size).sum

puts "--- Part 2: Count Unanimous Yeses per Group"
unanimi = 0
responses.each do |group|
  group.each do |individual|
    individual.keep_if { |response| group.all? { |sib| sib.include?(response) } }
  end
  unanimi += group.first.count
end

puts "For each group, count the number of questions to which everyone answered \"yes\"."
puts "What is the sum of those counts?"
puts unanimi
