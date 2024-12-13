#!/usr/bin/env ruby
puts '--- Day 10 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_10.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayTen
  def initialize
    @map = {}
    @trailheads = {}
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line ,ydex|
      line.strip.chars.map(&:to_i).each_with_index do |num, xdex|
        @map[[xdex, ydex]] = num
      end
    end
  end

  def part_one
    find_good_trails
    report(@trailheads.values.sum, 'Trail Score Total')
  end

  def find_good_trails
    find_trailheads
    follow_trails
  end

  def find_trailheads
    @map.each do |coords, num|
      @trailheads[coords] = 0 if num.zero?
    end
  end

  def follow_trails
    @trailheads.each_key do |trailhead|
      queue = [trailhead]
      visited = {}

      until queue.empty?
        current = queue.shift
        x, y = current

        neighbors = [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]
        neighbors.each do |neighbor|
          next if visited[neighbor] || !@map.key?(neighbor)

          if @map[neighbor] == @map[current] + 1
            queue << neighbor
            visited[neighbor] = true
          end
        end
      end
      @trailheads[trailhead] = visited.keys.count { |coords| @map[coords] == 9 }
    end
  end

  def report(value, name = nil)
    puts "#{name}: #{value}"
    system("echo #{value} | pbcopy")
    puts 'Copied to clipboard!'
  end

  def part_two
  end
end

day_ten = DayTen.new
puts '--- Part 1 ---'
day_ten.part_one
puts '--- Part 2 ---'
day_ten.part_two
