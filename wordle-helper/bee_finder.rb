#!/usr/bin/env ruby
#reuse letters

require 'json'

class WordFinder
  def initialize
    @dict = load_dictionary
    @words = []
    @honey = ''
  end

  def load_dictionary
    data = File.read('./dictionary.json')
    return JSON.parse(data)
  end

  def find(letters)
    @words = []
    unscrabble(letters)
    bee_worthy = beevaluate(@words)
    matches = @words & @dict
    puts "Great! I found the following words:"
    puts matches
  end

  def unscrabble(letters)
    chars = letters.chars
    @honey = chars[0]
    chars.each_index do |i|
      next if i < 3
      @words += chars.permutation(i+1).map &:join
    end
  end

  def beevaluate(matches)
    matches.keep_if { |m| m.include?(@honey) }
  end
end

wf = WordFinder.new
puts "Welcome to Bee Finder! Please input the letters for today's puzzle, beginning with the central letter."
until yn == n do
  puts "You may enter any letter multiple times, but be warned:"
  puts "A ten-letter search (3 doubles) takes about 12.5s, and an 11-letter search takes about 4.5m."
  letters = gets.chomp
  until /^[a-z]{7,11}$/.match letters.downcase
    puts "That doesn't seem right. Can you try entering the letters again, starting with the central letter?"
    letters = gets.chomp
  end
  puts "Let me think..."
  wf.find(letters)
  puts "Would you like to search again? Y/N"
  sa = gets.chomp
  until /^[yn]$/.match sa.downcase
    puts "I didn't get that. Would you like to search again? Y/N"
    sa = gets.chomp
  end
  yn = sa
end
puts "Thanks for using Bee Finder!"
