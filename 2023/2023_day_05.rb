#!/usr/bin/env ruby
require "pry"
puts '--- Day 5 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_05.txt'.freeze
INPUT = File.read(PATH).split("\n\n")
puts "Successfully read input from #{PATH}" if INPUT

class DayFive
  def initialize
    process(INPUT)
  end

  def mutate_seeds
    groups = @seeds.each_slice(2).to_a
    @seeds = []
    groups.each do |group|
      start, size = group
      @seeds << (start..(start + size - 1)).to_a
    end
    @seeds.flatten!
  end

  def locate_seeds
    @locations = []
    @seeds.each do |seed|
      new_val = seed
      1.upto(@maps.size) do |t|
        new_val = transition(new_val, @maps[t])
      end
      @locations << new_val
    end
  end

  def transition(val, maps)
    new_val = val
    map_dx = maps.count - 1
    until new_val != val || map_dx < 0
      new_val = translate(new_val, maps[map_dx])
      map_dx -= 1
    end
    new_val
  end

  def translate(val, map)
    dest_start, source_start, range_length = map
    if val >= source_start && val < source_start + range_length
      val += dest_start - source_start
    end
    val
  end

  def process(blocks)
    map_id = 1
    @maps = {}
    blocks.each do |block|
      matches = block.match(/(\w+):\n?(.+)/m)
      thing, numbers = matches[1], matches[2]
      case thing
      when 'seeds' then @seeds = numbers.split.map(&:to_i)
      when 'map'
        @maps[map_id] =
          numbers.split("\n")
          .map(&:split)
          .map{|l| l.map(&:to_i)}
        map_id += 1
      end
    end
  end

  def part_one
    locate_seeds
    puts @locations.min
  end

  def part_two
    # mutate_seeds -- prohibitively inefficient
    locate_seeds
    puts @locations.min
  end
end

day_five = DayFive.new
puts '--- Part 1 ---'
puts day_five.part_one
puts '--- Part 2 ---'
puts day_five.part_two
