#!/usr/bin/env ruby
require 'json'

INPUT_PATH = './dictionary.json'
DICTIONARY = JSON.parse(File.read(INPUT_PATH))
RINGS = [
  ['e','a','i'],
  ['n','d','a'],
  ['d','c','t'],
  ['e','o','i'],
  ['m','b','a'],
  ['p','o','e'],
  ['o','l','e'],
  ['l','i','t']
]

def find_indexes(letter)
  indexes = []
  RINGS.each_with_index do |ring, index|
    indexes << index if ring.include?(letter)
  end
  indexes
end

words = []
DICTIONARY.each do |word|
  chars = word.chars
  indexes = find_indexes(chars.first)
  indexes.each do |dx|
    found = false
    offset = 0
    RINGS.rotate(dx).cycle do |ring|
      char = chars[offset]
      found = true and break unless char
      break unless ring.include?(char)
      offset += 1
    end
    words << word and break if found
  end
end

puts words.reject { |word| word.length < 6 }.inspect
