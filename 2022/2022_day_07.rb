#!/usr/bin/env ruby
require 'pry'
PATH = './inputs/day_07.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class DrivMappr
  def initialize
    @dirs = {}
    @current_directory = 'root'
    mkdir(INPUT.first)
  end

  def run
    process_input
    report
  end

  def process_input
    INPUT.each do |line|
    binding.pry if @current_directory == nil
      puts line
      case line
      when /^\$ cd/
        cd(line)
      when /^\d/
        mem(line)
      when /^dir/
        mkdir(line)
      end
    end
  end

  def cd(line)
    target = line[/\S+$/]
    binding.pry if target == nil
    @current_directory = if target == '..'
    binding.pry if @dirs[@current_directory] == nil
                           @dirs[@current_directory].parent
                         else
                           target
                         end
    puts "cd #{target} (#{@current_directory})"
    puts @dirs
  end

  def mem(line)
    filesize = line[/^\d+/]
    @dirs[@current_directory].filesize += filesize.to_i
  end

  def mkdir(line)
    dirname = line[/\S+$/]
    if @dirs[dirname]
      @dirs["#{dirname}-copy"] = Dir.new("#{dirname}-1", @current_directory)
    else
      @dirs[dirname] = Dir.new(dirname, @current_directory)
    end
  end

  def report
    # puts INPUT
  end
end

class Dir
  attr_accessor :dirname, :filesize, :parent

  def initialize(dirname, cur_dir)
    @dirname = dirname
    @filesize = 0
    binding.pry if cur_dir == nil
    @parent = cur_dir
  end
end

puts '--- Day 7: No Space Left On Device ---'
puts '--- Part 1 ---'
dm = DrivMappr.new
dm.run

puts '--- Part 2 ---'
dm2 = DrivMappr.new
dm2.run
