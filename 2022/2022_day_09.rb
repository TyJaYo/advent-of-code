#!/usr/bin/env ruby
PATH = './inputs/day_09.txt'.freeze
INPUT = File.open(PATH).readlines.freeze
puts "Successfully read input from #{PATH}" if INPUT

class RopeRunnr
  def initialize
    @instructions = []
    @head_loc = [0, 0]
    @tail_loc = [0, 0]
    @tail_locs = [[0,0]]
  end

  def run
    process_instructions
    follow_instructions
    report
  end

  def process_instructions
    @instructions = INPUT.map(&:split)
                         .map { |e| e[1] = e.last.to_i; e }
  end

  def follow_instructions
    @instructions.each do |line|
      direction, distance = line
      puts "#{line}, #{@head_loc}, #{@tail_loc}"
      move(direction, distance, 'H')
    end
  end

  def move(direction, distance, tip)
    x_y_changes = case direction
      when 'L' then [-1, 0]
      when 'D' then [0, -1]
      when 'U' then [0, 1]
      when 'R' then [1, 0]
    end
    distance.times do
      update_location(x_y_changes, tip)
    end
  end

  def update_location(x_y_changes, tip)
    case tip
      when 'H' 
        @head_loc[0] += x_y_changes[0]
        @head_loc[1] += x_y_changes[1]
        compare_h_t
      when 'T'
        @tail_loc[0] += x_y_changes[0]
        @tail_loc[1] += x_y_changes[1]
        @tail_locs << @tail_loc.dup
    end
  end

  def compare_h_t
    h, t = @head_loc, @tail_loc
    hx, tx = h[0], t[0]
    hy, ty = h[1], t[1]
    dx, dy = hx - tx, hy - ty
    return unless dx.abs > 1 || dy.abs > 1
    x_y_changes = [delta(dx), delta(dy)]
    update_location(x_y_changes, 'T')
  end

  def delta(d)
    case 
    when d < 0 then -1
    when d > 0 then 1
    else 0
    end
  end

  def report
    p "The tail visited #{@tail_locs.uniq.count} places."
  end
end

puts '--- Day 9: Rope Bridge ---'
rr = RopeRunnr.new
rr.run
