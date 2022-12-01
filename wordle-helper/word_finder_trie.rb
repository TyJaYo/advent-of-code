#!/usr/bin/env ruby
require 'json'
require './trie'
require 'pry'

class WordFinder
  def initialize
    @trie = Trie.new
    # load_dictionary
    load_sample
    @words = []
  end

  def load_sample
    %w(cat cab bat capo batch).each do |word|
      @trie.add_word(word)
    end
  end

  def load_dictionary
    data = File.read('./dictionary.json')
    JSON.parse(data).each do |word|
      @trie.add_word(word)
    end
  end

  def find(letters)
    @trie.unscrabble(letters)
  end

  def print_trie
    @trie.print_traverse
  end
end
wf = WordFinder.new
wf.print_trie
