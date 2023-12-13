#!/usr/bin/env ruby
INPUT_PATH = './inputs/day_13.txt'
INPUT = File.read(INPUT_PATH)

class DayThirteen
  def initialize
    @maps = {}
    @cols_left  = 0
    @rows_above = 0
    process(INPUT)
  end

  def process(line)
    maps = line.split("\n\n")
    maps.each_with_index do |map, dx|
      lines = map.split("\n").map(&:chars)
      @maps[dx] = lines
    end
  end

  def find_symmetries
    @maps.each do |_, map|
      ['left-right', 'top-bottom'].each do |dir|
        find_symmetry(map, dir)
      end
    end
  end

  def find_symmetry(map, dir)
    map = map.transpose if dir == 'top-bottom'
    positions = (1...(map[0].size)).to_a
    map.each do |line|
      positions.reverse.each do |point|
        positions.delete(point) unless reflect?(line, point)
      end
    end
    @rows_above += positions.sum if positions.size == 1 && dir == 'top-bottom'
    @cols_left += positions.sum if positions.size == 1 && dir == 'left-right'
  end

  def reflect?(line, point)
    reflection = line.take(point).reverse
    after = line.drop(point)

    until reflection.size == after.size
      if reflection.size > after.size
        reflection.pop
      else
        after.pop
      end
    end
    return true if reflection == after
  end

  def find_smudges
    @maps.each do |_, map|
      ['left-right', 'top-bottom'].each do |dir|
        find_smudge(map, dir)
      end
    end
  end

  def find_smudge(map, dir)
    map = map.transpose if dir == 'top-bottom'
    positions = (1...(map[0].size)).to_a

    positions.each do |point|
      errors = map.sum do |line|
        errors_on_reflect(line, point)
      end
      if errors == 1
        @rows_above += point if dir == 'top-bottom'
        @cols_left += point if dir == 'left-right'

        break
      end
    end
  end

  def errors_on_reflect(line, point)
    errors = 0
    reflection = line.take(point).reverse
    after = line.drop(point)
    big, small = if reflection.length > after.length
      [reflection, after]
    else
      [after, reflection]
    end

    small.each_with_index do |char, dx|
      errors += 1 unless char == big[dx]
    end
    errors
  end

  def part_one
    find_symmetries
    puts @cols_left + @rows_above * 100
  end

  def part_two
    @cols_left  = 0
    @rows_above = 0
    find_smudges
    puts @cols_left + @rows_above * 100
  end
end

puts '--- Day 13 ---'
day_thirteen = DayThirteen.new
puts '--- Part 1 ---'
day_thirteen.part_one
puts '--- Part 2 ---'
day_thirteen.part_two
