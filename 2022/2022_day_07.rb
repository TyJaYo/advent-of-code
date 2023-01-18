#!/usr/bin/env ruby
PATH = './inputs/day_07.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class DrivMappr
  def initialize
    @sized = []
    @current_directories = []
  end

  def run
    process_input
    report
  end

  def process_input
    INPUT.each do |line|
      case line
      when /^\$ cd [^.]/
        up_tally(line)
      when /^\$ cd \./
        down_tally
      when /^\d/
        mem(line)
      end
    end
  end

  def up_tally(line)
    target = line[/\S+$/]
    @current_directories << [target, 0]
  end

  def mem(line)
    filesize = line[/^\d+/]
    @current_directories.each do |directory|
      directory[1] += filesize.to_i
    end
  end

  def down_tally
    @sized << @current_directories.pop
  end

  def report
    all = @current_directories + @sized
    candidates = all.select { |candidate| candidate.last <= 100_000 }
    puts candidates.map(&:last).sum
  end

  def report2
    all = @current_directories + @sized
    biggest = all.max_by { |e| e[1] }
    biggest_size = biggest.last
    total_size = 70_000_000
    unused = total_size - biggest_size
    needed = 30_000_000 - unused
    candidates = all.select { |candidate| candidate.last >= needed }
    puts candidates.min_by { |e| e[1] }.last
  end
end

puts '--- Day 7: No Space Left On Device ---'
puts '--- Part 1 ---'
dm = DrivMappr.new
dm.run

puts '--- Part 2 ---'
dm.report2
