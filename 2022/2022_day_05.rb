#!/usr/bin/env ruby
PATH = './inputs/day_05.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT
CSI = "\e["
WAIT = 1
WAIT2 = 2

class CargoStackr
  def initialize
    @yard_input = []
    @instructions = []
    process_input
 end

  def process_input
    INPUT.each do |line|
      nums = line.scan(/\s(\d+)/)
      case nums.size
      when 0
        @yard_input << line if line.chars.include?('[')
      when 3
        @instructions << nums
      end
    end
  end

  def refresh
    $stdout.write "#{CSI}2J"    # clear screen
    $stdout.write "#{CSI}1;1H"  # move to top left corner
    $stdout.write "#{CSI}s"     # save cursor position
  end

  def restore
    $stdout.write "#{CSI}u"     # restore cursor position
  end

  def render
    refresh
    $stdout.puts @yard_input
  end

  def wait
    sleep(WAIT)
  end
end

puts '--- Day 5: Supply Stacks ---'
cs = CargoStackr.new
cs.render
