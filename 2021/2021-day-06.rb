#!/usr/bin/env ruby

# INPUT = [3,4,3,1,2]
INPUT = [1,1,1,3,3,2,1,1,1,1,1,4,4,1,4,1,4,1,1,4,1,1,1,3,3,2,3,1,2,1,1,1,1,1,1,1,3,4,1,1,4,3,1,2,3,1,1,1,5,2,1,1,1,1,2,1,2,5,2,2,1,1,1,3,1,1,1,4,1,1,1,1,1,3,3,2,1,1,3,1,4,1,2,1,5,1,4,2,1,1,5,1,1,1,1,4,3,1,3,2,1,4,1,1,2,1,4,4,5,1,3,1,1,1,1,2,1,4,4,1,1,1,3,1,5,1,1,1,1,1,3,2,5,1,5,4,1,4,1,3,5,1,2,5,4,3,3,2,4,1,5,1,1,2,4,1,1,1,1,2,4,1,2,5,1,4,1,4,2,5,4,1,1,2,2,4,1,5,1,4,3,3,2,3,1,2,3,1,4,1,1,1,3,5,1,1,1,3,5,1,1,4,1,4,4,1,3,1,1,1,2,3,3,2,5,1,2,1,1,2,2,1,3,4,1,3,5,1,3,4,3,5,1,1,5,1,3,3,2,1,5,1,1,3,1,1,3,1,2,1,3,2,5,1,3,1,1,3,5,1,1,1,1,2,1,2,4,4,4,2,2,3,1,5,1,2,1,3,3,3,4,1,1,5,1,3,2,4,1,5,5,1,4,4,1,4,4,1,1,2]
HEADERS = [0,1,2,3,4,5,6,7,8,9]
DAYS = 256

class FishTimer
  def initialize
    @timers = Array.new(10,0)
    INPUT.each do |i|
      @timers[i] += 1
    end
    @days = 0
    @eggs = 0
  end
  def advance
    @timers.each_with_index do |t, i|
      next if i == 0
      @timers[i-1] = t
    end
  end
  def spawn
    @eggs += @timers[0]
    @timers[0] = 0
  end
  def hatch
    @timers[6] += @eggs
    @timers[8] += @eggs
    @eggs = 0
  end
  def day(t=1)
    t.times do
      self.spawn
      self.advance
      self.hatch
      @days += 1
    end
    report
  end
  def report
    puts "After #{@days} days, there are #{@timers.sum} fish."
    counts = HEADERS.zip(@timers)
    puts counts.inspect
  end
end

t = FishTimer.new
t.day(DAYS)
