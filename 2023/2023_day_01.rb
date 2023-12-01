#!/usr/bin/env ruby
puts '--- Day 1 ---'
puts '--- Part 0: Parse Input ---'
PATH = './inputs/day_01.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
WORD_VALUES = {
  'one'   => 1,
  'two'   => 2,
  'three' => 3,
  'four'  => 4,
  'five'  => 5,
  'six'   => 6,
  'seven' => 7,
  'eight' => 8,
  'nine'  => 9
}

puts "Successfully read input from #{PATH}" if INPUT

puts '--- Part 1 ---'
class DayOne
  def initialize
    @total = 0
    @part_two_total = 0
    @step_one = process(INPUT.dup)
    @step_two = reprocess(INPUT.dup)
  end

  def process(lines)
    lines.each do |line|
      linechars = line.chars
      linenums = []
      linechars.each do |char|
        if char.match(/\d/)
          linenums << char
        end
      end
      numstring = "#{linenums.first}#{linenums.last}"
      num = numstring.to_i
      @total += num
    end
  end

  def part_one
    @total
  end

  def reprocess(lines)
    lines.each do |line|
      numerals_dx = find_numerals_and_indexes(line)
      first_number_word_dx = find_first_number_word_and_index(line)
      last_number_word_dx = find_last_number_word_and_index(line)
      if first_number_word_dx && last_number_word_dx
        last_number_word_dx = nil if last_number_word_dx[1] == first_number_word_dx[1]
      end

      linenums = []
      linenums += numerals_dx
      linenums << first_number_word_dx
      linenums << last_number_word_dx
      linenums.compact!
      linenums.sort_by!(&:last)

      first = convert(linenums.first)
      last = convert(linenums.last)

      numstring = "#{first}#{last}"
      num = numstring.to_i
      @part_two_total += num
    end
  end

  def convert(ary)
    case ary[0].length
    when 1 then ary[0].to_i
    else WORD_VALUES[ary[0]]
    end
  end

  def find_numerals_and_indexes(str)
    linenums_dx = []
    str.chars.each_with_index do |char, dx|
      if char.match(/\d/)
        linenums_dx << [char, dx]
      end
    end
    linenums_dx
  end

  def find_first_number_word_and_index(str)
    res = []
    str.scan(/one|two|three|four|five|six|seven|eight|nine/) do |c|
      res << [c, $~.offset(0)[0]]
    end
    res.sort_by(&:last).first
  end

  def find_last_number_word_and_index(str)
    res = []
    str.reverse.scan(/enin|thgie|neves|xis|evif|ruof|eerht|owt|eno/) do |c|
      res << [c, $~.offset(0)[0]]
    end
    backwards = res.sort_by(&:last).first
    [backwards[0].reverse, str.length - backwards[1] - backwards[0].length] if backwards
  end

  def part_two
    @part_two_total
  end
end

day_one = DayOne.new
puts day_one.part_one
puts '--- Part 2 ---'
puts day_one.part_two
