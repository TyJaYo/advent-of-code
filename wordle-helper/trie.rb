#!/usr/bin/env ruby

class Array
  def delete_first(item)
    delete_at(index(item))
  end
end

class Node
  attr_reader   :value, :next
  attr_accessor :word

  def initialize(value)
    @value = value
    @word  = false
    @next  = []
  end
end

class Trie
  def initialize
    @root = Node.new('*')
  end

  def print_trie(base = @root, depth = 0)
    base.next.each do |n|
      print "#{' ' * depth}#{n.value}\n"
      print_trie(n, depth + 1) unless n.next.empty?
    end
  end

  def print_traverse
    traverse do |n, depth, path|
      print "#{' ' * depth}#{n.value}"
      print " - #{path + n.value}" if n.word
      print "\n"
    end
  end

  def traverse(base = @root, depth = 0, path = '', &block)
    base.next.each do |n|
      block.call(n, depth, path)
      traverse(n, depth + 1, path + n.value, &block) unless n.next.empty?
    end
  end

  def add_word(word)
    letters = word.chars
    base    = @root
    letters.each { |letter| base = add_character(letter, base.next) }
    base.word = true
  end

  def find_word(word)
    letters = word.chars
    base    = @root
    word_found =
      letters.all? { |letter| base = find_character(letter, base.next) }
    yield word_found, base if block_given?
    base
  end

  def add_character(character, trie)
    trie.find { |n| n.value == character } || add_node(character, trie)
  end

  def find_character(character, trie)
    trie.find { |n| n.value == character }
  end

  def add_node(character, trie)
    Node.new(character).tap { |new_node| trie << new_node }
  end

  def include?(word)
    find_word(word) { |found, base| return found && base.word }
  end

  # make new trie construction using recursion
  # re-write recursive traverse method with iteration + stack
  # re-write recursive traverse method with iteration + queue

  #def unscrabble(letters)
  #   tried_starts = []
  #   # 1. draw a letter
  #   # 2. find that letter from root
  #   # 3. draw another letter from letters
  #   # 4. try to find that letter from current node
  #   # 5. if you can, check if that next node is a word and record it, then repeat from 3 with new letter
  #   # 6. if you can't, repeat from 3 without new letter
  #   # 7. if you run out of letters repeat 1 with a new letter
  #   # 8. if you run out of starting letters, stop
  #   letters.each do |starting_letter|
  #     next if tried_starts.include?(starting_letter)
  #     tried_starts << starting_letter
  #     batch = letters
  #     batch.delete_first(starting_letter)

  #   end
  # end

  def find_words_starting_with(prefix)
    stack        = []
    words        = []
    prefix_stack = []
    stack        << find_word(prefix)
    prefix_stack << prefix.chars.take(prefix.size - 1)
    return [] unless stack.first

    until stack.empty?
      node = stack.pop
      prefix_stack.pop and next if node == :guard_node

      prefix_stack << node.value
      stack        << :guard_node
      words << prefix_stack.join if node.word
      node.next.each { |n| stack << n }
    end
    words
  end
end
