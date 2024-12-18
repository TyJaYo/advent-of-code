#!/usr/bin/env ruby
puts '--- Day 18 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_18.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
# MAP_SIZE = 6 + 1
MAP_SIZE = 70 + 1
# UNSAFE_COUNT = 12
UNSAFE_COUNT = 1024

puts "Successfully read input from #{PATH}" if INPUT

class DayEighteen
  def initialize
    @unsafe = {}
    process(INPUT)
  end

  def process(lines)
    lines.each_with_index do |line, dex|
      break if dex == UNSAFE_COUNT

      x, y = line.split(',').map(&:to_i)
      @unsafe[dex] = [x, y]
    end
  end

  def part_one
    make_map
    mark_all_unsafe
    find_shortest_path
    report(@shortest_path.size - 1, 'Shortest Path')
  end

  def make_map
    @map = Array.new(MAP_SIZE) { Array.new(MAP_SIZE, '.') }
  end

  def mark_all_unsafe
    @unsafe.each do |_, (x, y)|
      mark_unsafe(x, y)
    end
  end

  def mark_unsafe(x, y)
    @map[y][x] = '#'
  end

  def find_shortest_path
    @current = [0, 0]
    run_maze
  end

  def run_maze
    require 'set'
    start = [0, 0]
    goal = [MAP_SIZE - 1, MAP_SIZE - 1]

    open_set = Set.new([start])
    came_from = {}
    g_score = Hash.new(Float::INFINITY)
    g_score[start] = 0
    f_score = Hash.new(Float::INFINITY)
    f_score[start] = heuristic(start, goal)

    until open_set.empty?
      current = open_set.min_by { |pos| f_score[pos] }
      if current == goal
        @shortest_path = reconstruct_path(came_from, current)
        print_path(reconstruct_path(came_from, current))
        return
      end

      open_set.delete(current)
      neighbors(current).each do |neighbor|
        tentative_g_score = g_score[current] + 1
        if tentative_g_score < g_score[neighbor]
          came_from[neighbor] = current
          g_score[neighbor] = tentative_g_score
          f_score[neighbor] = g_score[neighbor] + heuristic(neighbor, goal)
          open_set.add(neighbor) unless open_set.include?(neighbor)
        end
      end
    end

    @shortest_path = [] # No path found
  end

  def heuristic(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs
  end

  def neighbors(pos)
    x, y = pos
    [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]].select do |nx, ny|
      nx.between?(0, MAP_SIZE - 1) && ny.between?(0, MAP_SIZE - 1) && @map[ny][nx] != '#'
    end
  end

  def reconstruct_path(came_from, current)
    total_path = [current]
    while came_from.key?(current)
      current = came_from[current]
      total_path.unshift(current)
    end
    total_path
  end

  def print_path(path)
    map_copy = @map.map(&:dup)
    path.each do |x, y|
      map_copy[y][x] = 'O'
    end
    map_copy.each { |row| puts row.join(' ') }
    puts
    sleep(0.1)
  end

  def report(value, name = nil)
    puts "#{name}: #{value}"
    system("echo #{value} | pbcopy")
    puts "Copied to clipboard!"
  end

  def part_two
    (UNSAFE_COUNT...INPUT.size).each do |dex|
      x, y = INPUT[dex].split(',').map(&:to_i)
      mark_unsafe(x, y)
      next unless @shortest_path.include?([x, y])

      find_shortest_path
      if @shortest_path.empty?
        report([x, y], 'Blocking Coordinate')
        @map[y][x] = 'X'
        # print_path(@shortest_path)
        break
      end
    end
  end
end

day_eighteen = DayEighteen.new
puts '--- Part 1 ---'
day_eighteen.part_one
puts '--- Part 2 ---'
day_eighteen.part_two
