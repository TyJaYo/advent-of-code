#!/usr/bin/env ruby
require "pry"

INPUT = ["1163751742","1381373672","2136511328","3694931569","7463417111","1319128137","1359912421","3125421639","1293138521","2311944581"]
ROWSIZE = INPUT.first.size
ROWCOUNT = INPUT.size

@riskmap = {}
INPUT.each_with_index do |string,rownum|
  string.each_char.with_index do |c,i|
    @riskmap[[i,rownum]] = c.to_i
  end
end
binding.pry

# def check_neighbors(row,pos,val)
#   higher_neighbors = [true]
#   unless top?(row)
#     higher_neighbors << check_north(row,pos,val)
#   end
#   unless eastest?(pos) || higher_neighbors.any? == false
#     higher_neighbors << check_east(row,pos,val)
#   end
#   unless bottom?(row) || higher_neighbors.any? == false
#     higher_neighbors << check_south(row,pos,val)
#   end
#   unless westest?(pos) || higher_neighbors.any? == false
#     higher_neighbors << check_west(row,pos,val)
#   end
#   if higher_neighbors.all? == true
#     @risk_sum += (val.to_i + 1)
#   end
# end

# def top?(row)
#   row == 0
# end
# def eastest?(pos)
#   pos == (ROWSIZE - 1)
# end
# def bottom?(row)
#   row == (ROWCOUNT - 1)
# end
# def westest?(pos)
#   pos == 0
# end

# def check_north(row,pos,val)
#   neighval = INPUT[row-1][pos]
#   check(val,neighval)
# end
# def check_east(row,pos,val)
#   neighval = INPUT[row][pos+1]
#   check(val,neighval)
# end
# def check_south(row,pos,val)
#   neighval = INPUT[row+1][pos]
#   check(val,neighval)
# end
# def check_west(row,pos,val)
#   neighval = INPUT[row][pos-1]
#   check(val,neighval)
# end

# def check(posval,neighval)
#   (posval <=> neighval) < 0
# end

# heightmap.each_with_index do |line,row|
#   line.each_char.with_index do |val,pos|
#     check_neighbors(row,pos,val)
#   end
# end


# routes = []
# INPUT.each { |i| routes << i.split('-') }
# INPUT.each { |i| routes << i.split('-').reverse }

# exits = Hash[(routes)]
# exits.each_key do |k|
#   ary = []
#   ary = routes.select { |r| r[0] == k }
#   ary.each_with_index do |r,i|
#     ary[i] = r[1]
#   end
#   exits[k] = ary
# end

# tried_routes = []
# tried_routes_before = ["sandwich"]
# tried_routes_after = ["different sandwich"]

# until tried_routes_before == tried_routes_after
#   tried_routes_before = tried_routes.dup
#   # binding.pry
#   current_route = ["start"] # start at start
#   until current_route.last == "end" # go til reaching the end
#     current_cave = current_route.last
#     possible_next_steps = exits[current_cave].dup
#     candidate_next_step = possible_next_steps.reject { |pns|
#       binding.pry if tried_routes.include?(current_route + [pns])
#       ((pns == pns.downcase) && current_route.include?(pns)) ||
#       tried_routes.include?(current_route + [pns])
#      }.first
#       binding.pry
#     if candidate_next_step == nil
#       current_route.pop
#       tried_routes << current_route
#       break
#     else
#       current_route << candidate_next_step
#       bad_next_step = []
#     end
#   end
#   tried_routes << current_route
#   tried_routes_after = tried_routes.dup
# end

# successful_routes = tried_routes.reject { |r| r.last != "end"  }
# puts successful_routes
# puts successful_routes.size
