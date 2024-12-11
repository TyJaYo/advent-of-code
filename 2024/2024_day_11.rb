#!/usr/bin/env ruby
class DayEleven
  def initialize
    @stones = {}
    @changes = {}
    process(File.read('./inputs/day_11.txt'))
  end

  def process(line)
    line.strip.split.each do |num|
      add_next(num)
    end
    apply_changes
  end

  def add_next(num, times = 1)
    @changes[num] ||= 0
    @changes[num] += (1 * times)
  end

  def blink(count)
    count.times do |i|
      @changes = {}

      @stones.each do |stone|
        anticipate(stone)
      end

      apply_changes
    end
    report(@stones.values.sum, 'Stone Count')
  end

  def anticipate(stone)
    key, count = stone
    number = key.to_i

    case number
    when 0 then anticipate_zero(count)
    when ->(n) { n.to_s.length.even? }
      anticipate_even_digits(number, count)
    else anticipate_else(number, count)
    end
  end

  def anticipate_zero(count)
    add_next(1, count)
  end

  def anticipate_even_digits(number, count)
    digits = number.to_s
    half = digits.length / 2
    first_half = digits[0, half].to_i
    second_half = digits[half, digits.length - half].to_i
    add_next(first_half, count)
    add_next(second_half, count)
  end

  def anticipate_else(number, count)
    add_next(number * 2024, count)
  end

  def apply_changes
    @stones = @changes
  end

  def report(value, name = nil)
    puts "#{name}: #{value}"
    system("echo #{value} | pbcopy")
    puts "Copied to clipboard!"
  end
end

day_eleven = DayEleven.new
puts '--- Part 1 ---'
day_eleven.blink(25)
puts '--- Part 2 ---'
day_eleven.blink(50)
