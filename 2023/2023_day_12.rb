#!/usr/bin/env ruby
INPUT_PATH = './inputs/day_12.txt'
INPUT = File.readlines(INPUT_PATH, chomp: true)

class DayTwelve
  def initialize
    @rows = {}
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, dx|
      springs, groups = line.split
      groups = groups.split(',').map(&:to_i)
      @rows[dx] = { springs: springs, groups: groups }
    end
  end

  def sum_arrangements
    @rows.sum do |_, data|
      springs = data[:springs]
      groups = data[:groups]
      possibilities = 0

      unknowns = find_indexes(springs, '?')
      count_arrangements(springs, groups, unknowns)
    end
  end

  def find_indexes(string, char)
    (0...string.length).find_all { |i| string[i] == char }
  end

  def count_arrangements(springs, groups, unknowns)
    possibilities = generate_possibilities(springs, unknowns)
    possibilities.sum do |possibility|
      legitimate?(possibility, groups) ? 1 : 0
    end
  end

  def legitimate?(possibility, groups)
    matches = possibility.scan(/#+/)
    match_sizes = matches.map(&:size)
    match_sizes == groups
  end

  def generate_possibilities(springs_string, unknown_dxs)
    combinations = ['.', '#'].repeated_permutation(unknown_dxs.size).to_a

    combinations.map do |combination|
      new_string = springs_string.dup
      combination.each_with_index do |char, i|
        new_string[unknown_dxs[i]] = char
      end
      new_string
    end
  end

  def unfold_records
    @rows.each do |row, data|
      springs = @rows[row][:springs].dup
      groups  = @rows[row][:groups].dup
      4.times do
        @rows[row][:springs] += springs
        @rows[row][:groups]  += groups
      end
    end
  end

  def part_one
    puts sum_arrangements
  end

  def part_two
    unfold_records
    puts @rows.inspect
  end
end

puts '--- Day 12 ---'
day_twelve = DayTwelve.new
puts '--- Part 1 ---'
# day_twelve.part_one
puts '--- Part 2 ---'
day_twelve.part_two
