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
  end

  def run
    massage_inputs
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
    @inputs[dex][1] = [address.to_i, @inputs[dex][1].to_i]
  end

  def output_sum
    puts 'What is the sum of all values left in memory after it completes?'
    puts @inputs.inspect
  end
end

bm = BitMasker.new
bm.run
