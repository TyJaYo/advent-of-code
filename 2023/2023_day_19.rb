#!/usr/bin/env ruby
INPUT_PATH = './inputs/day_19.txt'
INPUT = File.read(INPUT_PATH)

class DayNineteen
  def initialize
    @flows = {}
    @parts = []
    @accepts = []
    process(INPUT)
  end

  def process(raw)
    raw_flows, raw_parts = raw.split("\n\n")
    process_flows(raw_flows)
    process_parts(raw_parts)
  end

  def process_flows(raw_flows)
    raw_flows.split("\n").each do |line|
      id, raw_steps = line.scan(/(\w+){(.*)}/)[0]
      id = id.to_sym
      @flows[id] = []
      raw_steps.split(",").each do |step|
        if step.match?(/^\w+$/)
          dest = step
        else
          xmas, op, num, dest = step.scan(/(\w)?([<>])?(\d+)?:?(\w+)/)[0]
        end
        num = num.to_i unless num.nil?
        @flows[id] << [xmas&.to_sym, op, num, dest.to_sym].compact
      end
    end
  end

  def process_parts(raw_parts)
    raw_parts.split("\n").each do |part|
      raw_attrs = part.delete("{}").split(",")
      hashy = {}
      raw_attrs.each do |raw_attr|
        xmas, val = raw_attr.scan(/(\w)=(\d+)/)[0]
        hashy[xmas.to_sym] = val.to_i
      end
      @parts << hashy
    end
  end

  def sort_parts
    @parts.each do |part|
      work_flow(@flows[:in], part)
    end
  end

  def work_flow(flow, part)
    puts part.inspect
    dest = nil
    flow.each do |step|
      puts step.inspect
      dest ||= if step.size == 1
        step[0]
      elsif part[step[0]].method(step[1]).(step[2])
        step[3]
      end
      break unless dest.nil?
    end
    @accepts << part if dest == :A
    return if dest == :A || dest == :R
    work_flow(@flows[dest], part)
  end

  def part_one
    sort_parts
    puts @accepts.sum { |a| a.sum { |_, val| val }}
  end

  def part_two
  end
end

puts '--- Day 19 ---'
day_nineteen = DayNineteen.new
puts '--- Part 1 ---'
day_nineteen.part_one
puts '--- Part 2 ---'
day_nineteen.part_two
