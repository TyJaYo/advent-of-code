#!/usr/bin/env ruby
puts '--- Day 7 ---'
PATH = './inputs/day_07.txt'.freeze
INPUT = File.open(PATH).readlines.freeze

class DaySeven
  def initialize
    @operators = ['*', '+']
    @equations = []
    @test_value_sum = 0
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      result, operands = line.split(':')
      operands = operands.split.map(&:to_i)
      @equations << [result.to_i, operands]
    end
  end

  def evaluate_equations
    @equations.each do |equation|
      result, operands = equation
      @test_value_sum += evaluate(result, operands)
    end
  end

  def evaluate(result, operands)
    @operators.repeated_permutation(operands.size - 1).each do |ops|
      eval_result = operands.first
      ops.each_with_index do |op, index|
        if op == '||'
          eval_result = (eval_result.to_s + operands[index + 1].to_s).to_i
        else
          eval_result = eval_result.send(op, operands[index + 1])
        end
      end
      return result if eval_result == result
    end
    0
  end

  def part_one
    evaluate_equations
    report(@test_value_sum)
  end

  def report(value)
    puts "Sum of possible results: #{value}"
    system("echo #{value} | pbcopy")
    puts 'Copied to clipboard!'
  end

  def part_two
    @test_value_sum = 0
    @operators << '||'
    evaluate_equations
    report(@test_value_sum)
  end
end

day_seven = DaySeven.new
puts '--- Part 1 ---'
day_seven.part_one
puts '--- Part 2 ---'
day_seven.part_two
