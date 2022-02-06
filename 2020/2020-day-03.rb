#!/usr/bin/env ruby
require "pry"
# INPUT = ["..##.......","#...#...#..",".#....#..#.","..#.#...#.#",".#...##..#.","..#.##.....",".#.#.#....#",".#........#","#.##...#...","#...##....#",".#..#...#.#"]
INPUT = ["....#............#.###...#.#.#.",".#.#....##.........#.....##.#..",".#..#.#...####.##..#......#..##","......#...#...#.......#........","........#...###..#.#....#....#.","..##.....#.....#.#.........#.#.",".##.......#.#.#...#..#...##...#","...##.....#....##....#...###.#.","..#...#......##.#.##.....#.#..#",".#....#.###.........#..........",".#.#..##.....###.....###....#.#","....###....#......#...#......##","......##...#.##.........#.#..#.","##.#....##...#..##....#.#..#.##",".#...#..#.....#.#.......#...#..","..........#..###.###......##..#","..#.##.#..#......#.......###.#.","...#...#.#.#..#...#.#..........","#........#..#..#.#....#.##..###","#...#.....#..####.........####.",".....###..........#.#...##...#.",".....#...#..#.......#....##.#..","...........#..##.....#...#..#..","......##..#........#...........","#.#..#.#.#..#.....#....#.....#.","..#....##....##...#.....#......",".#.#....#..#.#......#..###...#.",".......#...#.#....##..#..#..#..",".#.#.#.......#....#.#.#.......#",".#..........#.##.#...#..#.#.##.","..#.#..........#.#....##.#.##..","###..#..#.#...##.#.#..#........","##....#...#....#....#...#.#....","#...#.#....#.##..##...#.#......","......#...#.###......##....#...",".................#.###......#..","##..#....#....##...###.#.#..###","..#..........#..####..##..#...#",".#......#..#.#...........##.#..",".#..#......#...#.#.#..#.#.#.#.#",".#......###.....#.#.#......##..","#..........#.##...#...........#","..#....#.##....#.........#.....",".#..##....#...##.........#..#..","....##..#.###..#.#...#..###..#.","..#......#........#...#.#......","........#..#..#..#...#.##......",".##.#.#......#...#.........#...","#..###.#...#....###.##..###....","........##.............#....#..","...#...............#....#.#....","#..........#..#..#.#.....#...#.",".#.............#...#.......#..#",".#..#..#...#........##.........",".....#.#..#.#..#..##.........#.","..#..##...#....#.#...#.###..#..","#...........##.....#...#.##....","#.#.#.#........##......#...#.#.","......#..#.###.#...#.##.##....#",".#....#...#....#........#....#.","..#.#..........#..##.......#..#",".....#...##..#................#",".#...............##...#.##...##","#.####....##.....#.......#.##..","......#.##.#...##..###..#.#....",".#.##.#...##..#.......#.#..#...","#...#.##..........##..........#","#.###...#...#..#.....#.#.##..##",".##.....#....#...##.....##.....","...#........#..###.###...#.....","##..#....#.....#...#.#....#.#..","#....#....#.#..........#...#..#","...##..#......#..#..#..#..#....",".....##...#..####..##.........#",".....#..#.#...#..#....##..##...","..#.......##.#..#.##...#.#....#",".#..#.#...##..##....#..#......#","..##.##..##...###..#....#...#..","........##.......##...##.....##",".#....###...#..#..#..#.......#.","#.###............#....##.....#.","..........#...#...##..#...#....","..#......#.##.......#....##..##","..#..###.....#...#.......#.....","#.#...##.....#...#....#.......#","....##.##.#....#.....#.#....#..","...#....#.###............#..###","#..##..#.........##.....#.#...#","....#.......##......#....#...#.","....#..##.#..........#.........","....#...#.###.......#...#.#....","#..#..#...#.......##...#..#.##.","#.......#...##.##......#.......","##..##...##...#......#...#...##","..#...#.#.####.#...##.....##...","#...#..#..#...##......#.#..#..#","..##..##.#.#..#...####.....###.",".#........#..##.###...#.##.#...","........#..#...##......#.#....#","..#...###.......##..##..#....#.",".##...#.#..#.##.......##.###...","#....#.#.#........#....#..#.##.","....#.##.#.##..#.#####.....###.","#.#..#..#...#.#..#.......#.#...","....#...#....###...............",".###.#.....#.#.......###......#","##...#.#.###....##..#...##.....","...#.#..#.###.#.......#...#.#..",".#...#....#...#..####....###...","..#....##.....##.#.#.##....#...","#....#..##.......#...##.##....#",".##..#.......#..#....###.......","#.##.....##.#.........#......##",".####.#...#.....#..#...#.##..#.","....#...........#.....#........",".#............##...#.......#.#.","#....#.##........#....#.#..#..#","#....#.##....#...##...#..#..#..","...#..#.####.#....#............","....#......#.........#.........","#....##....###.....#......#.#..","...#..#....#........###..#...#.","..#.#........#.#.#.###..#.#.#..",".....###.....##.#....###.#.....","##.#....#....##...##.###.#.##..",".###.#..#.......##...#...##....",".#...###........#.......##.##..","#......####...#...##.#.######..","....##.............#..##.##...#","...........#..##.#...#.#.#...#.","###.......#.##..#....#...#....#",".........#.....#.#.#..##.#.....","#...##..#....#..#.............#","...#.......#.##.............#.#",".....#..#...##......####..#....",".#.#.#.....#...####..#...##...#","#...#.#..#..#.#..#.##..........",".....#.##..#.#.##..#.#.#....#.#","...##..#...#...#..#....#.......","........#.#..#...#...#.#...#...","##..#........#..#.....#......##",".........#..#...#......#......#","..#.#.#........##...#.##.....##",".###....##....#...#....#..#....",".#.............###...#..##..###",".##.##.##.......###.........#.#","..#..###...#...#....#..#.#..#.#","......#..#.#..#.....#.#........","......#...####...#.#.....#.....",".#...##.......#..#......#...#..","#..#...#.......###..#..#.#.#.#.",".....#.....###.##....#.#.##.#.#","#........#....##...#..#.##..#..","...#.#........##....#.#..###.#.","#...#...##.........#........###","##...#.##..##...#.....#.###.#..","#.###.#.#..#...........##..#...","........#.......#..#..#.###....","#........#....#......###.......","..#.###.######...#.###..#......","...#...######..#.....#....#.#..","..#.......#..#..#.........#...#",".#...#..##.##.........##.......",".........#.#.##.#..#....#.#...#","#.......#....#......#.....###.#","##..............#.###........#.","..#.##..#.##.....#...#.#.#..###","..#.#......#..#..##.#........#.","..#.....#...#.#...#...###..#.#.",".......#...........#..#..#.#.##",".......#...##..#.###...........",".#........#.###.#..#..#..#..#..","##.#.##....#..###..#.##.##...#.",".....#....##.#........#.#.#....","....##....#..#..#....##....#.#.","#.....##....#.....#.###.#....#.",".#.##.##..#..#...#...........##","...#..###..#.....##....#.......","...#..##..###.#..#..#.#........","......##..#.......#..##.....###",".#...##.#.#.#......#...#.#.#.##","....#.#....#...#........#...#..","....#.#......#.#.###.#.#.##.#..","#..#........###..#..#..#.....#.","...#....#...##...#........##.##",".....#..#..#.....#....#.#...#..","..#.###....#.#..##......#.##.#.","..####......#..#.#.#..#.#####..",".......##..#..###.#............","..###.#........#..........##.##","#.#.........#.##.#......#..#...","...#.....#.....##..#..##.##..#.","#.#.##....#.......###....##....","...##.#..#...##.#..#......#..#.","..##.........#.##.#####...#.#..",".#....#...#....#.#.....##...###","##.....#..####............###.#","......#...........#....#.......",".#......#.....##...........###.","#......##.......#.#.#..##.....#","...###.#.....##.#...#.#....#.#.","...###.......#...#.............","..#..#.#....#.#.###.#.#.##..##.","..##...#..#.#..##.#.##....##...","..#...........#..#....#....#...","#.##...........#..#.#..##.#.#..","...##...##................#..#.",".#...#.##......#.#......#.####.","#.##....#....#.........#....###",".....###........#.#.#.##...#.##",".....#....#.#....#.........#..#","..#...#.#.#.#...#...#...##.#..#","###.......#.....#.............#","#.####.#.......#.#.#.#..#.#....","#..#..#####......#....#..##....","...............#.....#.#....###",".###.....#...#.##..#.#..#.#####","#.##.....#......##.......##....","..........###.......#...#.#....","..#.#..#...##.....#........#.#.","........##.##....#####.#.#..##.","..##.#.#...#####..........#.#.#","#.........#......##...#.....#..",".##.#........#...#..##...#...#.",".......##..#...#.....#.##......","....#.#...##..##..#....##......","#........#..........##..####.#.","...###...#.#.###.#...#....#.#.#",".....##.#.....#........#.#....#","#.......#....#...##..#......#..","...#..........#.#.#...#.#.###.#","....##.....#.##..#.#.#.........","#.##..##..#....#.........#...#.",".###..........#...##.#..#......",".....####.............##...###.",".#..#....#..#...#..#...........","#..#..##..#...#.##..#.###.#...#","......#.#..###...#..#.....#..#.","##.##......#...#.#...#.........","....##.#.......#.#..##....#.#.#","#..##..#...###.#....##.........",".............#.#....#...##..#..","..#....#...#.....#.##.#..##..##","##.#..##.#..##.#.#.##.#...#.#..",".##.#..#.#........##.#...##....","#.........##....##..#......#...",".#.#.......##...#..#......###.#","........#.#.#.#......#....#..#.","...##..#...#...#.##..#....#.#..","...#.#.#.#.......#.......###..#","...#..##..#####.#.....##.#..#..",".......#.#.....#.....#...#...##","#...#...#......##.#....##......","#.....#.#.#.....#....#......#..","..#..#.##.#......##..#.#..#..##","####...#.....#....#.#..........","....#.....###...#...##......#..",".....#....#...#............#...","...#...#..##.........#...#...##","#.#..#.#...##.#.......#..#.#...",".#.....#...##.............#...#",".....#..##..#....#......#.##..#","....#...###.................#..","...###...#....#...#...#........","....#.##.#.......#..#..........","...#..#......#.#...###...#.#...","..#.#..#...#.......#.......#.#.",".#.#...#.#.##........#.........","...#..#...#....#.#.#.#.#..###..",".#..##......#.#.##..#.##....#..","#....#.......##.....#.#........","..###..#.#.#.......##....#.....","........#.#.#....##...##..#....","#....##.#....#...##..##...#....","...#..##.#.....#...#.....##....",".#.#..#..#...#....#..##.#....#.","##.#.##....#.....#....#....#.#.",".##......#............##...#...","#..##.#.####.#.#....#..#..#.#.#","#...##...#......##....###.....#","..#.##.....#....#....#......#..",".##.#...#.....#.#.#.#........##",".#..#....#.#...........#...#...","#.....#..#.....#.#.##.#.....#..","....#.....#..#.#....###........",".....###...........#.#..##.#.#.","....###....#.......###..#...#.#",".###.....#...##.#...##........#","..#..#.#..#...#.#...#.#..#...#.","#.####.......#....##.#..#.#..#.","....#.#.##.#..###.........##.#.","..#..#.#....#....#.##..........","..##.###..#.#..#.#......#....#.",".#..#.....##...#.#......##.#..#","#.#....#..#.#.#........#.###...","...#....##....##..###.###.#.#..","..#....#.....#....##.#.........","#.......#....#.........##..#...",".#..#...#.#..#.#....#.#........","...#..###...#.....#......##....","..#...........#.....#..........","....###.#...#......#...#..#....",".....#.##..#..#....#.......#..#","....##..#.#.#..............#.#.",".#.#..#..#.#......#...#.#......","....#.......#.##....##.#.#.#..#","............#.#.#.....##.......","........#...##.#..#......#...##",".........#...#...#....#...#.##.","..#.....#......#......#.....#..","#....#...##..#.#....#.#...#.###",".......#..#..#..#.#...#.....#.#","...#.#...#......##.....#..#....","...#.#.####..##.#..#...........","..##..##....#.....####...#....#","###.......#...##.#...#...#...#.",".##..#.....#..####......#....#.","#.....#..#..##..##...#..#..#...",".#....#.....#...####..####.....","..#....#...#......#........#.#.","##.#.......#..#.....#..##..##..",".#..#..#.#.#...#....##...#.##.#","##...#..#....#.........##......"]

# --- Day 3: Toboggan Trajectory ---

puts "--- Part 1: Count Hit Trees ---"
RIGHT = 3
DOWN = 1
aput = INPUT.map(&:chars)

dx = 0
hits = 0
for t in (1...aput.size).step(DOWN) do
  dx += RIGHT
  hits += 1 if aput[t].rotate(dx).first == '#'
end

puts "On a slope of right #{RIGHT}, down #{DOWN}, you hit #{hits} trees."

puts "--- Part 2: Check Multiple Slopes ---"
SLOPES_TO_CHECK = [[1,1],[3,1],[5,1],[7,1],[1,2]]
all_hits = []
SLOPES_TO_CHECK.each do |slope|
  aput = INPUT.map(&:chars)
  right, down = slope
  dx = 0
  hits = 0
  for t in (1...aput.size).step(down) do
    dx += right
    hits += 1 if aput[t].rotate(dx).first == '#'
  end
  all_hits << hits
  puts "On a slope of right #{right}, down #{down}, you hit #{hits} trees."
end
puts "Multiplied together, that's #{all_hits.reduce(:*)}."

puts "--- Part 3: GUI ---"
CSI = "\e["
GINPUT = INPUT.collect { |row| row.gsub(/\./,"⬜").gsub(/#/,"🌲") }
SLEEPYTIME = 0.1
class Mountain
  def initialize(right=3,down=1)
    @map = GINPUT.map(&:chars)
    @slope = [right,down]
    @current_row = 0
  end
  def move_sled # not finished
    replaced = @map[@current_row][0]
    @map[@current_row][0] = "🛷"
  end
  def rotate(times)
    times.times do
      @map.map do |ro|
        ro.rotate!
      end
      show
      sleep(SLEEPYTIME)
    end
  end
  def show # needs to be restricted to show a limited area around the sled
    $stdout.write "#{CSI}2J"    # clear screen
    $stdout.write "#{CSI}1;1H"  # move to top left corner
    puts "Slope: Right #{@slope[0]}, Down #{@slope[1]}."
    @map.each do |row|
      row.each do |sq|
        print "#{sq}"
      end
      print "\n"
    end
  end
end
m = Mountain.new
binding.pry
