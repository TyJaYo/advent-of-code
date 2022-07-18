# !/usr/bin/env ruby
# frozen_string_literal: true

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
    @mask = []
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
      ary[35 - bit] = num[bit]
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
    masked_bits = apply_mask(input[1])
    @memory[input[0]] = masked_bits.join.to_i(2)
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

puts '--- Part 2: memory address decoder ---'
# Class for solving Part 2
class BitMaskerV2
  def initialize
    @inputs = INPUT.dup
    @memory = []
    @mask = []
    @permutation_tables = []
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
    @inputs[dex][1] = [expand_bits(address.to_i), @inputs[dex][1].to_i]
  end

  def expand_bits(num)
    ary = []
    35.downto(0) do |bit|
      ary[35 - bit] = num[bit]
    end
    ary
  end

  def process_inputs
    @inputs.each do |input|
      case input[0]
      when 'mask' then @mask = construct_mask(input[1])
      else write_to_mem(input[1])
      end
    end
  end

  def construct_mask(input)
    input.each_with_index do |char, dex|
      input[dex] = char.to_i unless char == 'X'
    end
    input
  end

  def write_to_mem(input)
    masked_address = apply_mask(input[0])
    permuted_addresses = permute(masked_address)
    permuted_addresses.each do |address|
      @memory[address.join.to_i(2)] = input[1]
    end
  end

  def permute(address)
    permuted_addresses = []
    ex_count = address.count('X')
    ex_dexes = address.each_index.select { |dex| address[dex] == 'X' }
    add_permutation_table(ex_count) unless @permutation_tables[ex_count]
    @permutation_tables[ex_count].each do |permutation|
      address_permutation = address.dup
      permutation.each_with_index do |value, dex|
        address_permutation[ex_dexes[dex]] = value
      end
      permuted_addresses << address_permutation
    end
    permuted_addresses
  end

  def add_permutation_table(count)
    @permutation_tables[count] = [0, 1].repeated_permutation(count).to_a
  end

  def apply_mask(bits)
    @mask.each_with_index do |maskbit, dex|
      bits[dex] = maskbit unless maskbit == 0
    end
    bits
  end

  def output_sum
    puts 'What is the sum of all values left in memory after it completes?'
    puts @memory.compact.sum
  end
end

bm2 = BitMaskerV2.new
bm2.run
