#!/usr/bin/env ruby
puts '--- Day 5 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_05.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayFive
  def initialize
    @ranges = []
    @ids = []
    @fresh_ids = []
    @all_possible_fresh_counts = []
    process(INPUT)
    # puts "Processed #{@ids.count} IDs and #{@ranges.count} ranges"
    # puts "Ranges: #{@ranges.inspect}"
    # puts "IDs: #{@ids.inspect}"
  end

  def process(lines)
    lines.each do |line|
      bottom, top = line.split('-').map(&:to_i)
      next if bottom == 0

      unless top
        @ids << bottom
        next
      end

      if @ranges.empty?
        @ranges << [bottom, top]
      else
        merged = false
        @ranges.each do |range|
          range_bottom, range_top = range
          if top >= range_bottom - 1 && bottom <= range_top + 1
            range[0] = [range_bottom, bottom].min
            range[1] = [range_top, top].max
            merged = true
            break
          end
        end
        @ranges << [bottom, top] unless merged
        @ranges.sort_by! { |r| r[0] }
        i = 0
        while i < @ranges.size - 1
          curr = @ranges[i]
          nxt = @ranges[i + 1]
          if curr[1] >= nxt[0] - 1
            curr[1] = [curr[1], nxt[1]].max
            @ranges.delete_at(i + 1)
          else
            i += 1
          end
        end
      end
    end
    @ids.sort!
    @ranges.sort_by! { |range| range[0] }
  end

  def part_one
    find_fresh
    show(@fresh_ids.uniq.count)
  end

  def find_fresh
    @ids.each do |id|
      @ranges.each do |range|
        range_bottom, range_top = range
        if id >= range_bottom && id <= range_top
          @fresh_ids << id
          break
        elsif id < range_bottom
          break
        end
      end
    end
  end

  def part_two
    find_fresh
    @ranges.each do |range|
      @all_possible_fresh_counts << range[1] - range[0] + 1
    end
    show(@all_possible_fresh_counts.sum)
  end

  def show(result)
    puts result
    system("echo #{result} | pbcopy")
    puts 'Copied to clipboard'
  end
end

day_five = DayFive.new
puts '--- Part 1 ---'
day_five.part_one

day_five = DayFive.new
puts '--- Part 2 ---'
day_five.part_two
