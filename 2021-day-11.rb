#!/usr/bin/env ruby
require 'pry'

INPUT = ["8261344656","7773351175","7527856852","1763614673","8674556743","6853382153","4135852388","2846715522","7477425863","4723888888"]
SINPUT = ["5483143223","2745854711","5264556173","6141336146","6357385478","4167524645","2176841721","6882881134","4846848554","5283751526"]
ROWSIZE = INPUT.first.size
ROWCOUNT = INPUT.size
SLEEPYTIME = 0.1
STEPCOUNT = 100
CSI = "\e["

class Octomap
  attr_reader :flashcount
  def initialize(stringlines)
    @flashcount = 0
    @octomap = {}
    stringlines.each_with_index do |string,rownum|
      string.each_char.with_index do |c,i|
        @octomap[[i,rownum]] = c.to_i
      end
    end
  end
  def show(t='p')
    $stdout.write "#{CSI}2J"    # clear screen
    $stdout.write "#{CSI}1;1H"  # move to top left corner
    counter = ROWSIZE
    @octomap.each do |k, v|
      counter -= 1
      if counter > 0
        $stdout.print v
      else
        $stdout.puts v
        counter = ROWSIZE
      end
    end
    puts "After #{t} steps..."
    sleep(SLEEPYTIME)
  end
  def step
    @octomap.each_key { |k| inc(k) } # all values += 1
    flashed = []
    while 'Tyler' > 'Everyone'
      flashers = @octomap.select { |k, v| v > 9 && !flashed.include?(k)} .keys  # flash if > 9 and haven't flashed
      break if flashers.empty?
      flashers.each do |f| # adjacent to flash += 1
        neighbors = []
        neighbors << [f[0]-1,f[1]-1] # NW
        neighbors << [f[0],f[1]-1]   # N
        neighbors << [f[0]+1,f[1]-1] # NE
        neighbors << [f[0]-1,f[1]]   # W
        neighbors << [f[0]+1,f[1]]   # E
        neighbors << [f[0]-1,f[1]+1] # SW
        neighbors << [f[0],f[1]+1]   # S
        neighbors << [f[0]+1,f[1]+1] # SE
        neighbors.each do |n|
          inc(n) unless @octomap[n] == nil
        end
      end
      flashed += flashers
      @flashcount += flashers.size
    end
    flashed.each do |f|
      @octomap[f] = 0
    end
  end
  def flash(pos)
    @flashers << pos
    @octomap[pos] = -9
  end
  def inc(k)
    @octomap[k] = (@octomap[k] + 1)
  end
end
# --- Part One ---
om = Octomap.new(INPUT)
STEPCOUNT.times do |t|
  om.step
  om.show(t+1)
end
puts "#{om.flashcount} flashes"

# --- Part Two ---

