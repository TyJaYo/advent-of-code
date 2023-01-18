#!/usr/bin/env ruby
PATH = './inputs/day_07.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class DrivMappr
  def initialize
    @sizes = []
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
    @sizes << @current_directories.pop
  end

  def report
    all = @current_directories + @sizes
    candidates = all.select { |size| size.last <= 100_000 }
    puts candidates.map(&:last).sum
  end
end

puts '--- Day 7: No Space Left On Device ---'
puts '--- Part 1 ---'
dm = DrivMappr.new
dm.run

# puts '--- Part 2 ---'
# dm2 = DrivMappr.new
# dm2.run
