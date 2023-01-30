#!/usr/bin/env ruby
PATH = './inputs/day_08.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class TreeSee
  def initialize
    @map = []
    @edge_seeing_trees = []
    @row_last_index = 0
    @scenic_scores = {}
    @highest_score = 0
  end

  def run
    see_the_forest
    see_from_each_tree
    report
  end

  def see_the_forest
    INPUT.each do |line|
      @map << line.chomp.chars.map(&:to_i)
    end
    @row_last_index = @map[0].size - 1
  end

  def see_from_each_tree
    @map.each_with_index do |r, ri|
      r.each_with_index do |t, ti|
        %w[west east north south].each do |dir|          
          look(r, ri, t, ti, dir)
        end
      end
    end
  end

  def look(r, ri, t, ti, direction)
    trees_to_see = case direction
      when 'west' then r[0...ti]
      when 'east' then r[ti + 1..@row_last_index]
      when 'north' then @map[0...ri].map { |e| e.at(ti) }
      when 'south' then @map[ri + 1..@row_last_index].map { |e| e.at(ti) }
    end
    if trees_to_see.all? { |ot| ot < t }
      mark_tree(ti, ri)
    end
    trees_to_see.reverse! if direction == 'west' || direction == 'north'
    scenic_score(trees_to_see, t, ti, ri)
  end

  def scenic_score(trees_to_see, t, ti, ri)
    index_to_check = 0
    @scenic_scores[[ti, ri]] ||= 1
    current_dir_score = 1
    dir_length = trees_to_see.size
    unless dir_length == 0
      until index_to_check == dir_length || trees_to_see[index_to_check] >= t
        current_dir_score += 1
        index_to_check += 1 
      end
    end
    @scenic_scores[[ti, ri]] = @scenic_scores[[ti, ri]] * current_dir_score
  end

  def mark_tree(x, y)
    @edge_seeing_trees << [x, y]
  end

  def report
    p "#{@edge_seeing_trees.uniq.count} trees are visible from the perimiter."
    p "#{@scenic_scores.max_by { |k, v| v }} is the highest scenic score."
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
ts = TreeSee.new
ts.run
