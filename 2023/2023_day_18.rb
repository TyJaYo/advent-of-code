#!/usr/bin/env ruby
INPUT_PATH = './inputs/day_18.txt'
INPUT = File.readlines(INPUT_PATH, chomp: true)
DIR_CODES = {
  '0' => :R,
  '1' => :D,
  '2' => :L,
  '3' => :U
}

class DayEighteen
  def initialize(part: 1)
    @map = Hash.new { |h, k| h[k] = Hash.new(' ') }
    @x, @y = 0, 0
    @min_x, @max_x = 0, 0
    @min_y, @max_y = 0, 0
    @insts = []
    case part
      when 1 then process(INPUT)
      when 2 then reprocess(INPUT)
    end
  end

  def process(lines)
    lines.each do |line|
      dir, len, hue = line.scan(/^(\w)\s(\d+)\s\(#(\w+)/)[0]
      hue = hue.chars.each_slice(2).map(&:join).map(&:hex)
      @insts << [dir.to_sym, len.to_i, hue]
    end
  end

  def reprocess(lines)
    lines.each do |line|
      hex_len, coded_dir = line.scan(/\(#(\w{5})(\w)\)/)[0]
      @insts << [DIR_CODES[coded_dir], hex_len.hex]
    end
  end

  def follow_instructions
    @insts.each do |inst|
      draw(inst)
    end
  end

  def draw(instruction)
    direction, steps = instruction
    case direction
    when :R
      steps.times { @map[@y][@x += 1] = '#'; @max_x = [@max_x, @x].max }
    when :L
      steps.times { @map[@y][@x -= 1] = '#'; @min_x = [@min_x, @x].min }
    when :U
      steps.times { @map[@y -= 1][@x] = '#'; @min_y = [@min_y, @y].min }
    when :D
      steps.times { @map[@y += 1][@x] = '#'; @max_y = [@max_y, @y].max }
    end
  end

  def display
    flood_fill(1, 1, ' ', '#')
    (@min_y..@max_y).each do |y|
      (@min_x..@max_x).each do |x|
        print @map[y][x]
      end
      puts
    end
  end

  def flood_fill(x, y, old_char, new_char)
    stack = [[x, y]]

    while stack.any?
      x, y = stack.pop
      next if x < @min_x || x > @max_x || y < @min_y || y > @max_y
      next if @map[y][x] != old_char

      @map[y][x] = new_char

      stack.push([x+1, y])
      stack.push([x-1, y])
      stack.push([x, y+1])
      stack.push([x, y-1])
    end
  end

  def count_octothorpes
    count = 0
    @map.each_value do |row|
      row.each_value do |cell|
        count += 1 if cell == '#'
      end
    end
    count
  end

  def part_one
    follow_instructions
    display
    puts count_octothorpes
  end

  def part_two
    part_one
  end
end

puts '--- Day 18 ---'
day_eighteen = DayEighteen.new
puts '--- Part 1 ---'
day_eighteen.part_one
puts '--- Part 2 ---'
# day_eighteen = DayEighteen.new(part: 2)
# day_eighteen.part_two
