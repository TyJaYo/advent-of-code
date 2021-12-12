#!/usr/bin/env ruby
require 'pry'

# INPUT = []
INPUT = ["5483143223","2745854711","5264556173","6141336146","6357385478","4167524645","2176841721","6882881134","4846848554","5283751526"]
ROWSIZE = INPUT.first.size
ROWCOUNT = INPUT.size
SLEEPYTIME = 1
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
    @octomap.each do |k,v|
      counter -= 1
      if counter > 0
        $stdout.print v
      else
        $stdout.puts v
        counter = ROWSIZE
      end
    end
    puts t
    sleep(SLEEPYTIME)
  end
  def step
    @octomap.each {|k,v| inc(k,v)} # all values += 1
    while @octomap.any? { |k,v| v > 9 } # while any > 9
      @octomap.each do |k,v| # flash if > 9
        if v > 9
          flash(k)
        end
      end
      @flashers.each do |f| # adjacent to flash += 1
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
          @octomap[n] += 1 unless @octomap[n] == nil # || @flashers&.any? { |f| f == n  }
          binding.pry if @flashers&.any? { |f| f == k  }
        end
        show
      end
      if @flashers # 0 if flashed
        @flashers.each do |f|
          @octomap[f] = 0
          # show
        end
        @flashers = []
      end
    end
  end
  def flash(pos)
    @flashers << pos
    @octomap[pos] = -9
    @flashcount += 1
  end
  def inc(k,v)
    @octomap[k] = (v + 1) unless @flashers&.any? { |f| f == k  }
    binding.pry if @flashers&.any? { |f| f == k  }
  end
end
# --- Part One ---
om = Octomap.new(INPUT)
STEPCOUNT.times do |t|
  om.show(t)
  om.step
end
puts om.flashcount

# --- Part Two ---

