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

  def scan_str(str, pattern)
    res = []
    (0..str.length).each do |i|
      res << [Regexp.last_match.to_s, i] if str[i..-1] =~ /^#{pattern}/
    end
    res
  end

  def reprocess(lines)
    lines.each do |line|
      numwords_dx = scan_str(line, "(one|two|three|four|five|six|seven|eight|nine)") # [["eight", 0], ["seven", 5], ["six", 10], ["six", 32]]
      # puts "numwords_dx: #{numwords_dx}"

      linenums_dx = []
      line.chars.each_with_index do |char, dx|
        if char.match(/\d/)
          linenums_dx << [char, dx]
        end
      end
      # puts "linenums_dx: #{linenums_dx}"

      combo = (numwords_dx + linenums_dx).compact
      # puts "combo: #{combo}"
      combo.sort_by!(&:last)
      if combo.size > 1
        first_last = [combo.first, combo.last]
      else
        first_last = combo
      end

      # puts "#{first_last}!"

      linenums = []

      first_last.each do |entry|
        entry = entry[0]
        if entry.match(/\d/)
          linenums << entry
        else
          linenums << WORD_VALUES[entry]
        end
      end

      if linenums.size > 1
        numstring = "#{linenums.first}#{linenums.last}"
      else
        numstring = linenums.first
      end
      num = numstring.to_i
      puts "#{line} -- #{num}"
      @part_two_total += num
    end
  end

  def part_two
    @part_two_total
  end
end

day_one = DayOne.new
puts day_one.part_one
puts '--- Part 2 ---'
puts day_one.part_two
