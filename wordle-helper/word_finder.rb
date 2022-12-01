#!/usr/bin/env ruby
require 'json'

class WordFinder
  def initialize
    @dict = load_dictionary
    @words = []
  end

  def load_dictionary
    data = File.read('./dictionary.json')
    return JSON.parse(data)
  end

  def find(letters)
    @words = []
    unscrabble(letters)
    matches = @words & @dict
  end

  def unscrabble(letters)
    chars = letters.chars
    chars.each_index do |i|
      @words += chars.permutation(i+1).map &:join
    end
  end
end
