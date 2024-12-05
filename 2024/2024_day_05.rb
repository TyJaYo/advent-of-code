#!/usr/bin/env ruby
puts '--- Day 5 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_05.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

puts "Successfully read input from #{PATH}" if INPUT

class DayFive
  def initialize
    @order_rules = []
    @page_orders = []
    @good_orders = []
    @bad_orders = []
    @good_middles = 0
    @fixed_middles = 0
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      line_str = line.strip
      next if line_str.empty?
      @order_rules << line_str.split('|').map(&:to_i) if line.include?('|')
      @page_orders << line_str.split(',').map(&:to_i) if line.include?(',')
    end
  end

  def validate_page_orders
    @page_orders.each do |page_order|
      valid = true
      @order_rules.each do |valid_order|
        next unless page_order.include?(valid_order[0]) && page_order.include?(valid_order[1])

        valid = false unless page_order.index(valid_order[0]) < page_order.index(valid_order[1])
        break unless valid
      end
      @good_orders << page_order if valid
      @bad_orders << page_order if !valid
    end
  end

  def sum_middles(orders)
    @sum_of_middles = 0
    orders.each do |order|
      middle_index = order.length / 2
      @sum_of_middles += order[middle_index]
    end
  end

  def report
    puts "The sum of the middles of good orders is #{@sum_of_middles}"
    system("echo #{@sum_of_middles} | pbcopy")
    puts 'Copied to clipboard!'
  end

  def part_one
    validate_page_orders
    sum_middles(@good_orders)
    report
  end

  # def part_two # Way too slow. Probably need topological sort.
  #   fix_bad_orders
  #   sum_middles(@bad_orders)
  #   report
  # end

  # def fix_bad_orders
  #   rule_list_size = @order_rules.size
  #   @bad_orders.each do |bad_order|
  #     @order_rules.each do |valid_order|
  #       loop do
  #         passing_rules = 0
  #         @order_rules.each do |rule|
  #           next unless bad_order.include?(rule[0]) && bad_order.include?(rule[1])

  #           if bad_order.index(rule[0]) > bad_order.index(rule[1])
  #             bad_order[bad_order.index(rule[0])] = rule[1]
  #             bad_order[bad_order.index(rule[1])] = rule[0]
  #           else
  #             passing_rules += 1
  #           end
  #         end
  #         break if passing_rules == rule_list_size
  #       end
  #     end
  #   end
  # end
end

day_five = DayFive.new
puts '--- Part 1 ---'
day_five.part_one
puts '--- Part 2 ---'
day_five.part_two
