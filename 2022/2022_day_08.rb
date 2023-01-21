#!/usr/bin/env ruby
PATH = './inputs/day_08.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT
ROW_LENGTH = INPUT
require 'colorize'

class TreeSee
  def initialize
    @ew_map = []
    @ns_map = []
    @seen_trees = []
  end

  def run
    see_the_forest
    see_the_trees
    report
  end

  def see_the_forest
    INPUT.each do |line|
      @ew_map << line.chomp.chars.map(&:to_i)
    end
    @ns_map = @ew_map.transpose
  end

  def see_the_trees
    look_from_east
    look_from_west
    look_from_north
    look_from_south
  end

  def look_from_east
    @ew_map.each_with_index do |row, rownum|
      see_tree(0, rownum)
      i = 1
      while row[i] > row[i - 1]
        see_tree(i, rownum)
        i += 1
      end
    end
  end

  def look_from_west
    last_index = @ew_map[0].size - 1
    @ew_map.each_with_index do |row, rownum|
      see_tree(last_index, rownum)
      i = last_index - 1
      while row[i] > row[i + 1]
        see_tree(i, rownum)
        i -= 1
      end
    end
  end

  def look_from_north
    @ns_map.each_with_index do |col, colnum|
      see_tree(colnum, 0)
      i = 1
      while col[i] > col[i - 1]
        see_tree(colnum, i)
        i += 1
      end
    end
  end

  def look_from_south
    last_index = @ns_map[0].size - 1
    @ns_map.each_with_index do |col, colnum|
      see_tree(colnum, last_index)
      i = last_index - 1
      while col[i] > col[i + 1]
        see_tree(colnum, i)
        i -= 1
      end
    end
  end

  def see_tree(x, y)
    @seen_trees << [x, y]
  end

  def report
    unique_trees = @seen_trees.uniq
    p "#{unique_trees.count} trees are visible from the perimiter"
  end

  def report2
    unique_trees = @seen_trees.uniq
    count = 0
    99.times do |y|
      99.times do |x|
        if unique_trees.include?([x, y])
          print "#{@ns_map[x][y]}".red
          count += 1
        else
          print @ns_map[x][y]
        end
      end
      print "\n"
    end
    print count
  end
end

puts '--- Day 8: Treetop Tree House ---'
puts '--- Part 1 ---'
ts = TreeSee.new
ts.run

puts '--- Part 2 ---'
ts.report2
