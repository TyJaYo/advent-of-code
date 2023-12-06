#!/usr/bin/env ruby
puts '--- Day 6 ---'
PATH = './inputs/day_06.txt'.freeze
INPUT = File.readlines(PATH)

class DaySix
  def process(lines: INPUT, part: 1)
    lines.each do |line|
      header, numbers = line.split(':')
      case header
      when 'Time' then @times = process_numbers(part, numbers)
      when 'Distance' then @dists = process_numbers(part, numbers)
      end
    end
  end

  def process_numbers(part, numbers)
    case part
    when 1 then numbers.split.map(&:to_i)
    when 2 then [numbers.split.join.to_i]
    end
  end

  def calculate_winning_strats
    @ways_to_win = []
    @times.zip(@dists).each do |race|
      @ways_to_win << winning_strat_count(*race)
    end
  end

  def winning_strat_count(time, dist)
    quad = Math.sqrt((time ** 2) - (4 * dist)) / 2
    max = time/2 + quad
    min = time/2 - quad
    max.ceil - min.floor - 1
  end

  def part_one
    process
    calculate_winning_strats
    puts @ways_to_win.inject(1) { |product, num| product *= num }
  end

  def part_two
    process(part: 2)
    calculate_winning_strats
    puts @ways_to_win
  end
end

day_six = DaySix.new
puts '--- Part 1 ---'
puts day_six.part_one
puts '--- Part 2 ---'
puts day_six.part_two
