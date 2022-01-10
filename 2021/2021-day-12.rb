#!/usr/bin/env ruby
require 'pry'

INPUT = ["start-A","start-b","A-c","A-b","b-d","A-end","b-end"]

routes = []
INPUT.each { |i| routes << i.split('-') }
INPUT.each { |i| routes << i.split('-').reverse }

exits = Hash[(routes)]
exits.each_key do |k|
  ary = []
  ary = routes.select { |r| r[0] == k }
  ary.each_with_index do |r,i|
    ary[i] = r[1]
  end
  exits[k] = ary
end

tried_routes = []
tried_routes_before = ["sandwich"]
tried_routes_after = ["different sandwich"]

until tried_routes_before == tried_routes_after
  tried_routes_before = tried_routes.dup
  # binding.pry
  current_route = ["start"] # start at start
  until current_route.last == "end" # go til reaching the end
    current_cave = current_route.last
    possible_next_steps = exits[current_cave].dup
    candidate_next_step = possible_next_steps.reject { |pns|
      binding.pry if tried_routes.include?(current_route + [pns])
      ((pns == pns.downcase) && current_route.include?(pns)) ||
      tried_routes.include?(current_route + [pns])
     }.first
      binding.pry
    if candidate_next_step == nil
      current_route.pop
      tried_routes << current_route
      break
    else
      current_route << candidate_next_step
      bad_next_step = []
    end
  end
  tried_routes << current_route
  tried_routes_after = tried_routes.dup
end

successful_routes = tried_routes.reject { |r| r.last != "end"  }
puts successful_routes
puts successful_routes.size

