#!/usr/bin/env ruby
PATH = './inputs/day_08.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

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
      trees_to_see_over = []
      for i in 0...row.size
        if trees_to_see_over.all? { |t| t < row[i] }
          see_tree(i, rownum)
        end
        trees_to_see_over << row[i]
      end
    end
  end

  def look_from_west
    @ew_map.each_with_index do |row, rownum|      
      trees_to_see_over = []
      last_index = row.size - 1
      last_index.downto(0) do |i| 
        if trees_to_see_over.all? { |t| t < row[i] }
          see_tree(i, rownum)
        end
        trees_to_see_over << row[i]
      end
    end
  end

  def look_from_north
    @ns_map.each_with_index do |col, colnum|      
      trees_to_see_over = []
      for i in 0...col.size
        if trees_to_see_over.all? { |t| t < col[i] }
          see_tree(colnum, i)
        end
        trees_to_see_over << col[i]
      end
    end
  end

  def look_from_south
    @ns_map.each_with_index do |col, colnum|      
      trees_to_see_over = []
      last_index = col.size - 1
      last_index.downto(0) do |i| 
        if trees_to_see_over.all? { |t| t < col[i] }
          see_tree(colnum, i)
        end
        trees_to_see_over << col[i]
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
          print `tput setaf 1` + "#{@ns_map[x][y]}" + `tput sgr0`
          count += 1
        else
          print @ns_map[x][y]
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
ts.report2

puts '--- Part 2 ---'
