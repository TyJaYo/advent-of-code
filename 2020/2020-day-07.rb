#!/usr/bin/env ruby
require "pry"
puts "--- Day 7: Handy Haversacks ---"
puts "--- Part 0: Parse Input ---"
PATH = './inputs/day-07.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).freeze
puts "Successfully read input from #{PATH}" if INPUT

@rules = {}
INPUT.each do |line|
  container, contained = line.split(" bags contain ")
  contained = contained.scan(/(\d+.*?)bag/)
    .flatten
    .map { |x| x.split(' ',2) }
    .map { |y| y.map(&:strip) }
  contained.each do |count_and_color|
    count_and_color[0] = count_and_color[0].to_i
  end
  @rules[container] = contained
end
# puts @rules.first.inspect => ["bright indigo", [[4, "shiny turquoise"], [3, "wavy yellow"]]]

puts "--- Part 1: Count Unique Bag Colors Holding Shiny Gold Bags ---"
def drill(cont)
  color = cont.last
  if color == "shiny gold"
    @chain.each do |link|
      @gold_holders << link
    end
  end
  @rules[color].each do |cont|
    drill(cont)
  end
end

@gold_holders = []
@rules.each_pair do |container, contained|
  next if @gold_holders.include? container
  @chain = [container]
  contained.each do |cont|
    drill(cont)
  end
end

puts "How many bag colors can eventually contain at least one shiny gold bag?"
puts @gold_holders.uniq.count
