#!/usr/bin/env ruby
require 'json'
require 'pry'

class WordFinder
  def initialize
    @dict = load_dictionary
    @words = []
    @groups = []
  end

  def load_dictionary
    data = File.read('./dictionary.json')
    return JSON.parse(data)
  end

  def get_groups
    puts "What letters do you see? Please enter 12 letters, keeping sides together:"
    input = gets.chomp.downcase
    until is_valid?(input)
      puts "I don't understand. Please enter 12 letters with groups of 3 together:"
      input = gets.chomp.downcase
    end
    @groups = [input[0,3].chars, input[3,3].chars, input[6,3].chars, input[9,3].chars]
    display_groups = [input[0,3], input[3,3], input[6,3], input[9,3]]
    puts "Great! Here's what I wrote down:"
    @groups.each do |group|
      group.each do |char|
        print char.upcase
      end
      print "\n"
    end
  end

  def is_valid?(input)
    input != nil && input.downcase.match(/[a-z]{12}/)
  end

  def find_words
    @groups.each do |group|
      group.each do |char|
        begins_with_char = @dict.select { |wd| wd[0] == char }

      end
    end
  end

end

wf = WordFinder.new
binding.pry
