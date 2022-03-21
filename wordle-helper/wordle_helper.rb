#!/usr/bin/env ruby
require 'json'
WORD_LENGTH = 5

class WordleFinder
  def initialize
    @matches = load_abridged_dictionary
    @info = []
    @known_inclusions = ""
    @known_exclusions = ""
  end

  def load_abridged_dictionary
    data = File.read('./dictionary.json')
    array = JSON.parse(data)
    right_length = array.select! { |wd| wd.length == WORD_LENGTH }
  end

  def run
    greet
    ask_about_overall
    ask_about_each_letter_position
    interpret_info
    share_results
  end

  def share_results
    puts "Here are any matches I found! Sorry if they're bad."
    puts @matches.inspect
  end

  def interpret_info
    slot_params = @info.join
    @matches.select! { |mtch| mtch.match? /#{slot_params}/ }
    @matches.select! { |mtch| (mtch.chars & @known_exclusions.chars).empty? }
    @matches.reject! { |mtch| (mtch.chars & @known_inclusions.chars).empty? }
  end

  def greet
    puts "Hello, and welcome to Tyler's Wordle helper!"
    puts "I'm going to ask you a series of questions, then share matches I find."
    puts "I'm using my own word list, but hopefully I know enough words to help."
  end

  def ask_about_overall
    puts "First off, let's cover what you've learned about the target word thus far."
    puts "Are there any letters you know are in the word, but you don't know where? (y/n)"
    input = get_letter
    if input == "y"
      puts "Great! Please enter the letters you know are somewhere in the word."
      puts "You don't need to enter letters here if you know where they occur."
      @known_inclusions = get_letters
    end
    puts "Are there any letters you know are NOT anywhere in the target word? (y/n)"
    input = get_letter
    if input == "y"
      puts "Great! Please enter the letters that aren't anywhere in the word."
      @known_exclusions = get_letters
    end
  end

  def ask_about_each_letter_position
    for i in 0...WORD_LENGTH
      ask_about(i)
    end
  end

  def ask_about(letter_index)
    letter_number = letter_index + 1
    puts "Do you know what letter #{letter_number} is? (y/n)"
    input = get_letter
    if input == "y"
      puts "Great! Please enter the known letter now:"
      remember_good(letter_index)
    elsif input.match? /^n/
      puts "Are there letters you don't want to consider for letter #{letter_number}? (y/n)"
      input = get_letter
      if input == "y"
        puts "Great! Please enter letters that letter #{letter_number} cannot be."
        remember_bad(letter_index)
      end
    else
      puts "I didn't understand your answer."
      ask_about(letter_index)
    end
  end

  def remember_good(letter_index)
    input = get_letter
    @info[letter_index] = input
  end

  def remember_bad(letter_index)
    input = get_letters
    @info[letter_index] = "[^#{input}]"
  end

  def get_letter
    input = gets.chomp.downcase[0]
  end

  def get_letters
    input = gets.chomp.downcase
  end
end

wf = WordleFinder.new
wf.run
