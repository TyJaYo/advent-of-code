#!/usr/bin/env ruby
puts '--- Day 7 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_07.txt'.freeze
INPUT = File.readlines(PATH)
puts "Successfully read input from #{PATH}" if INPUT
CARD_STRENGTHS = {
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  'T' => 10,
  'J' => 11,
  'Q' => 12,
  'K' => 13,
  'A' => 14
}

class DaySeven
  def initialize
    @hands = {}
    process(INPUT)
  end

  def process(lines)
    lines.each do |line|
      hand, bid = line.split
      @hands[hand] = {
        cards: hand.chars,
        bid: bid.to_i
      }
    end
  end

  def inspect_hands
    @hands.each do |hand, data|
      @hands[hand][:sets]       = get_sets(@hands[hand][:cards])
      @hands[hand][:set_size]   = max_set_size(@hands[hand][:sets])
      @hands[hand][:set_count]  = @hands[hand][:sets].size
      @hands[hand][:card_ranks] = rank_cards(@hands[hand][:cards])
    end
  end

  def inspect_for_jokers
    @hands.each do |hand, data|
      @hands[hand][:card_ranks] = rank_cards(data[:cards])
      joker_count = data[:cards].count('J')
      if data[:sets].any?{ |set| set.include?('J')}
        @hands[hand][:sets] = [data[:sets].flatten!]
        @hands[hand][:set_size] = max_set_size(data[:sets])
        if data[:sets][0].all? { |e| e == 'J' } && @hands[hand][:set_size] < 5
          @hands[hand][:set_size] += 1
        end
        @hands[hand][:set_count] = data[:sets].size
      elsif joker_count > 0
        @hands[hand][:set_size] += joker_count
        if @hands[hand][:set_count] == 0
          @hands[hand][:set_count] += 1
          @hands[hand][:set_size] += 1
        end
      end
    end
  end

  def get_sets(cards)
    cards.sort.group_by { |e|
      e
    }.values.select { |group|
      group.size > 1
    }
  end

  def max_set_size(sets)
    sets.max_by { |set| set.size }&.size || 0
  end

  def rank_cards(cards)
    cards.map { |card| CARD_STRENGTHS[card] }
  end

  def rank_hands
    hands_array = @hands.values
    rankings = {}

    hands_array.each do |hand1|
      rankings[hand1] = hands_array.map do |hand2|
        compare_hands(hand1, hand2)
      end
    end

    hands_array.sort_by do |hand|
      rankings[hand].reduce(:+)
    end
  end

  def compare_hands(hand1, hand2)
    # Compare set size first
    result = hand1[:set_size] <=> hand2[:set_size]

    # If set sizes are equal, compare set count
    if result == 0
      result = hand1[:set_count] <=> hand2[:set_count]
    end

    # If set size and count are equal, compare card ranks one by one
    if result == 0
      hand1_ranks, hand2_ranks = hand1[:card_ranks], hand2[:card_ranks]
      hand1_ranks.each_index do |i|
        result = hand1_ranks[i] <=> hand2_ranks[i]
        break if result != 0
      end
    end

    # Return the comparison result
    result
  end

  def award_winnings(hands)
    hands.each_with_index do |hand, dx|
      winnings = hand[:bid] * (dx + 1)
      @hands[hand[:cards].join][:winnings] = winnings
    end
  end

  def award_and_show_winnings
    award_winnings(rank_hands)
    puts @hands.values.map { |data| data[:winnings] }.sum
  end

  def update_strengths
    CARD_STRENGTHS['J'] = 1
  end

  def part_one
    inspect_hands
    award_and_show_winnings
  end

  def part_two
    update_strengths
    inspect_for_jokers
    award_and_show_winnings
  end
end

day_seven = DaySeven.new
puts '--- Part 1 ---'
puts day_seven.part_one
puts '--- Part 2 ---'
puts day_seven.part_two
