# frozen_string_literal: true

# !/usr/bin/env ruby

puts '--- Day 14: Docking Data ---'

puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_14.txt'
INPUT = File.open(PATH).readlines.map(&:chomp).freeze

puts "Successfully read input from #{PATH}" if INPUT

puts '--- Part 1: initialization program ---'
# Class for solving Part 1
class BitMasker
  def initialize
    @inputs = INPUT.dup
    @memory = []
    @mask = Array.new(36, 'X')
  end

  def run
    massage_inputs
    process_inputs
    output_sum
  end

  def massage_inputs
    @inputs.each_with_index do |input, dex|
      @inputs[dex] = input.split(' = ')
      case @inputs[dex][0]
      when 'mask' then @inputs[dex][1] = @inputs[dex][1].chars
      else massage_mem(dex)
      end
    end
  end

  def massage_mem(dex)
    @inputs[dex][0], address = @inputs[dex][0].match(/(mem)\[(\d+)\]/).captures
    @inputs[dex][1] = [address.to_i, expand_bits(@inputs[dex][1].to_i)]
  end

  def expand_bits(num)
    ary = []
    35.downto(0) do |bit|
      dex = 35 - bit
      ary[dex] = num[bit]
    end
    ary
  end

  def process_inputs
    @inputs.each do |input|
      case input[0]
      when 'mask' then @mask = input[1]
      else write_to_mem(input[1])
      end
    end
  end

  def write_to_mem(input)
    address, bits = input[0], input[1]
    bits = apply_mask(bits)
    @memory[address] = bits.join.to_i(2)
  end

  def apply_mask(bits)
    @mask.each_with_index do |maskbit, dex|
      bits[dex] = maskbit unless maskbit == 'X'
    end
    bits
  end

  def output_sum
    puts 'What is the sum of all values left in memory after it completes?'
    puts @memory.compact.sum
  end
end

bm = BitMasker.new
bm.run
