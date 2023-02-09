#!/usr/bin/env ruby
PATH = './inputs/day_11.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT
ROUND_COUNT = 20

class MonkyChasr
  def initialize
    $monkys = {}
    @monky_props = {}
    @max_monky_dex = -1
  end

  def run
    process_input
    ROUND_COUNT.times { play_round }
    report
  end

  def process_input
    INPUT.each do |line|
      key = line.match(/(\S+)\:/)
      if key == nil 
        make_monkey(@monky_props)
        next 
      end
      key = key.captures.first.downcase.to_sym
      value = line.match(/\: (.+)/)&.captures&.first
      if key.length == 1
        value = key.to_s.to_i
        key = :number
      end
      @monky_props[key] = value
    end
    make_monkey(@monky_props)
  end

  def make_monkey(props)
    $monkys[props[:number]] = Monky.new(props)
    @monky_props = {}
    @max_monky_dex += 1
  end

  def play_round
    for m in 0..@max_monky_dex
      monky = $monkys[m]
      monky.go_through_items
    end
  end

  def report
    for m in 0..@max_monky_dex
      p "Monkey #{m} inspected items #{$monkys[m].items_inspected} times."
    end
    top_two = $monkys.max_by(2){ |k, v| v.items_inspected }
    p "The most active monkeys were #{top_two.first.first} and #{top_two.last.first}"
    top_two_nums = top_two.map{ |k, v| v.items_inspected }
    p "The level of monkey business is #{top_two_nums.inject(:*)}"
  end
end

class Monky
  attr_accessor(
    :items, 
    :operation, 
    :divisible_by, 
    :true_receiver, 
    :false_receiver, 
    :items_inspected
  )

  def initialize(props)
    @items = props[:items].scan(/\d+/).map(&:to_i)
    @operation = operationalize(props[:operation])
    @divisible_by = grab_num(props[:test])
    @true_receiver = grab_num(props[:true])
    @false_receiver = grab_num(props[:false])
    @items_inspected = 0
  end

  def grab_num(str)
    str.match(/(\d+)/).captures.first.to_i
  end

  def operationalize(str)
    ary = str.match(/(old) (.) (.+)/).captures
    hsh = {
      :ands => [ary[0], ary[2]],
      :op => ary[1].to_sym
    }
  end

  def go_through_items
    self.items.count.times do |t|
      item = self.items.shift
      inspected_item = inspect_item(item)
      if throw_true?(inspected_item)
        throw_item(item, inspected_item, self.true_receiver) 
      else
        throw_item(item, inspected_item, self.false_receiver)
      end
      self.items_inspected += 1
    end
  end

  def inspect_item(item)
    ands = self.operation[:ands].dup
    ands.each_index do |i|
      if ands[i] == 'old'
        ands[i] = item 
      else
        ands[i] = ands[i].to_i
      end
    end
    ands.inject(self.operation[:op]) / 3
  end

  def throw_true?(item)
    item % self.divisible_by == 0
  end

  def throw_item(thrown, caught, receiver)
    $monkys[receiver].items << caught
  end
end

puts '--- Day 11: Monkey in the Middle ---'
mc = MonkyChasr.new
mc.run
