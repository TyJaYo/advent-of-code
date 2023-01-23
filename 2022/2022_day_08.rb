#!/usr/bin/env ruby
PATH = './inputs/day_08.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT
require "pry"

class TreeSee
  def initialize
    @map = []
    @edge_seeing_trees = []
    @row_last_index = 0
  end

  def run
    see_the_forest
    see_the_edge
    report
    report2
  end

  def see_the_forest
    INPUT.each do |line|
      @map << line.chomp.chars.map(&:to_i)
    end
    @row_last_index = @map[0].size - 1
  end

  def see_the_edge
    @map.each_with_index do |r, ri|
      r.each_with_index do |t, ti|
        look(r, ri, t, ti, 'west')
        look(r, ri, t, ti, 'east')
        look(r, ri, t, ti, 'north')
        look(r, ri, t, ti, 'south')
      end
    end
  end

  def look(r, ri, t, ti, direction)
    trees_to_see_over = case direction
      when 'west' then  r[0...ti]
      when 'east' then  r[ti + 1..@row_last_index]
      when 'north' then  @map[0...ri].map { |e| e.at(ti) }
      when 'south' then  @map[ri + 1..@row_last_index].map { |e| e.at(ti) }
    end
    if trees_to_see_over.all? { |ot| ot < t }
      mark_tree(ti, ri)
    end
  end

  def mark_tree(x, y)
    @edge_seeing_trees << [x, y]
  end

  def report
    p "#{@edge_seeing_trees.uniq.count} trees are visible from the perimiter"
  end

  def report2
    count = 0
    99.times do |y|
      99.times do |x|
        if @edge_seeing_trees.include?([x, y])
          print `tput setaf 1` + "#{@map[y][x]}" + `tput sgr0`
          count += 1
        else
          print @map[y][x]
        end
      end
      print "\n"
    end
    puts count
  end
end

puts '--- Day 8: Treetop Tree House ---'
puts '--- Part 1 ---'
ts = TreeSee.new
ts.run

puts '--- Part 2 ---'
