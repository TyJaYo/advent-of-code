#!/usr/bin/env ruby
INPUT_PATH = './inputs/day_15.txt'
INPUT = File.read(INPUT_PATH)

class DayFifteen
  def initialize
    @total = 0
    @steps = []
    @insts = []
    @boxes = {}
    process(INPUT.chomp)
  end

  def process(line)
    line.split(',').each do |step|
      @steps << step
    end
  end

  def reprocess
    @steps.each do |step|
      label, op = step.scan(/(\w+)([=-])/).first
      num = step.match(/\d/)[0].to_i if op == '='
      box = algo(label)
      @insts << [box, label, op, num]
    end
  end

  def follow_instructions
    @insts.each do |box, label, op, num|
      @boxes[box] ||= {}
      case op
      when '-' then @boxes[box].delete(label)
      when '=' then @boxes[box][label] = num
      end
    end
  end

  def total_focus
    @boxes.sum do |box, lenses|
      lens_count = 0
      lenses.sum do |_, len|
        lens_count += 1
        (1 + box) * lens_count * len
      end
    end
  end

  def algo_all
    @total += @steps.sum do |step|
      algo(step)
    end
  end

  def algo(str)
    current = 0
    ascii_vals = str.codepoints
    ascii_vals.each do |val|
      current = (current + val) * 17 % 256
    end
    current
  end

  def part_one
    algo_all
    puts @total
  end

  def part_two
    reprocess
    follow_instructions
    puts total_focus
  end
end

puts '--- Day 15 ---'
day_fifteen = DayFifteen.new
puts '--- Part 1 ---'
day_fifteen.part_one
puts '--- Part 2 ---'
day_fifteen.part_two
