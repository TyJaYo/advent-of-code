#!/usr/bin/env ruby
puts '--- Day 17 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_17.txt'.freeze
INPUT = File.read(PATH).freeze

puts "Successfully read input from #{PATH}" if INPUT

class DaySeventeen

  def initialize
    @registers = {}
    @program = []
    @output = []
    process(INPUT)
  end

  def process(lines)
    lines.split("\n").each do |line|
      if line.start_with?('Register')
        key, value = line.split(': ')
        register_key = key.split.last
        @registers[register_key] = value.to_i
      elsif line.start_with?('Program')
        key, value = line.split(': ')
        @program = value.split(',').map(&:to_i)
      end
    end
  end

  def part_one
    run_program_from(0)
    report(@output.join(','), 'Output')
  end

  def run_program_from(start)
    @program[start..-1].each_slice(2) do |opcode, operand|
      case opcode
      when 0 then dv(operand, 'A')
      when 1 then b_xor(operand)
      when 2 then mod(operand, 'B')
      when 3 then jnz(operand)
      when 4 then b_xor(@registers['C'])
      when 5 then mod(operand, 'out')
      when 6 then dv(operand, 'B')
      when 7 then dv(operand, 'C')
      end
    end
  end

  # opcodes 0, 6, 7
  # divide register A by 2^(combo(operand))
  # store result in given register
  def dv(operand, register)
    numerator = @registers['A']
    denominator = 2 ** combo(operand)
    @registers[register] = numerator / denominator
  end

  # opcodes 1, 4
  # bitwise XOR register B with operand
  def b_xor(operand)
    @registers['B'] = @registers['B'] ^ operand
  end

  # opcodes 2, 5
  # store combo(operand) % 8 in target
  def mod(operand, target)
    result = combo(operand) % 8
    if target == 'out'
      @output << result
      return
    end

    @registers[target] = result
  end

  # opcode 3
  # jump to program index if register A is not zero
  def jnz(operand)
    return if @registers['A'] == 0

    run_program_from(operand)
  end

  def combo(operand)
    case operand
    when 0..3 then operand
    when 4 then @registers['A']
    when 5 then @registers['B']
    when 6 then @registers['C']
    when 7 then nil # invalid
    end
  end

  def report(value, name = nil)
    puts "#{name}: #{value}"
    system("echo #{value} | pbcopy")
    puts "Copied to clipboard!"
  end

  def part_two
    # Implement part two logic here
  end
end

day_seventeen = DaySeventeen.new
puts '--- Part 1 ---'
day_seventeen.part_one
puts '--- Part 2 ---'
day_seventeen.part_two
