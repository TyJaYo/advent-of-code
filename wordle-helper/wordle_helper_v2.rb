#!/usr/bin/env ruby

class WordleFinder
  def initialize
    @words = File.readlines('./dictionary5.txt').map(&:chomp)
    @guess_count = 0
    @coded_guesses = []
    @regex_string = []
    @known_inclusions = []
    @known_exclusions = []
    @known_doubles = []
    @known_singles = []
  end

  def run
    greet
    get_guess_count
    ask_about_guesses
    process_each_guess
    interpret_info
    share_results
  end

  def greet
    puts "Hello, and welcome to Tyler's Wordle helper 2.0!"
    puts "I'm going to ask you about your guesses, then share possible words."
  end

  def get_guess_count
    puts "How many guesses have you made?"
    puts "Please enter a number 1–5."
    input = get_letter.to_i
    unless input.between?(1, 5)
      express_confusion
      get_guess_count
    end
    @guess_count = input
  end

  def ask_about_guesses
    puts "Great! I'll have you enter each word, followed by the colors."
    @guess_count.times do |guess_index|
      puts "Let's talk about guess ##{guess_index + 1}."
      ask_about_guess
    end
  end

  def ask_about_guess
    @current_guess = []
    2.times do |t|
      get_word_input(t)
    end
    @coded_guesses << @current_guess
  end

  def get_word_input(idx)
    case idx
    when 0 then puts "What word did you enter?"
    when 1
      puts "What colors did your word's letters become?"
      puts "Write a letter code per space (example: 'gybby' for 🟩🟨🔲🔲🟨)"
      puts "'g' = green, 'y' = yellow, 'b' = blank"
    end
    input = get_string
    unless legit_for_case?(input, idx)
      express_confusion
      get_word_input(idx)
    end
    @current_guess << input.chars
  end

  def legit_for_case?(input, idx)
    case idx
    when 0 then return input.match?(/[A-Za-z]{5}/)
    when 1 then return input.match?(/[gyb]{5}/)
    end
  end

  def express_confusion
    puts [
      "⛔️ I'm not sure what you mean by that.",
      "⛔️ I'm sorry, I didn't quite get that.",
      "⛔️ Apologies, I don't understand that.",
      "⛔️ I was not programmed to accept what you wrote there.",
      "⛔️ My programmer did not instruct me how to process that input.",
      "⛔️ The meaning of your input eludes me, despite my amazing capabilities."
    ].sample
  end

  def process_each_guess
    @coded_guesses.each do |guess|
      process_each_letter_position(guess)
    end
  end

  def process_each_letter_position(guess)
    @hits = []
    5.times do |i|
      process(guess[0][i], guess[1][i], i)
    end
  end

  def process(letter, code, idx)
    case code
    when 'g'
      @known_doubles << letter if @hits.include?(letter)
      @regex_string[idx] = letter
      @hits << letter
    when 'y'
      @known_doubles << letter if @hits.include?(letter)
      @regex_string[idx] = "[^#{letter}]"
      @known_inclusions << letter
      @hits << letter
    when 'b'
      @regex_string[idx] = "."
      if @hits.include?(letter)
        @known_singles << letter
      else
        @known_exclusions << letter
      end
    else
      puts "💥 Fatal error. Shutting down."
      exit
    end
  end

  def interpret_info
    slot_params = @regex_string.join
    @words.select! { |mtch| mtch.match? /#{slot_params}/ }
    @words.reject! { |mtch| @known_exclusions.any? { |ke| mtch.include?(ke) } }
    @words.select! { |mtch| @known_inclusions.all? { |ki| mtch.include?(ki) } }
    unless @known_singles.empty?
      @words.reject! { |mtch| @known_singles.any? { |ks| has_two?(mtch, ks) } }
    end
    unless @known_doubles.empty?
      @words.select! { |mtch| @known_doubles.all? { |kd| has_two?(mtch, kd) } }
    end
  end

  def has_two?(word, character)
    word.count(character) >= 2
  end

  def share_results
    puts "Here are any and all matches I found! Sorry if they're bad."
    puts @words.inspect
  end

  def get_letter
    input = gets.chomp.downcase[0]
  end

  def get_string
    input = gets.chomp.downcase
  end
end

wf = WordleFinder.new
wf.run
