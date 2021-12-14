#!/usr/bin/env ruby

# PT = "NNCB"
# INPUT = ["CH -> B","HH -> N","CB -> H","NH -> C","HB -> C","HC -> B","HN -> C","NN -> C","BH -> H","NC -> B","NB -> B","BN -> B","BB -> N","BC -> B","CC -> N","CN -> C"]
PT = "SHHBNFBCKNHCNOSHHVFF"
INPUT = ["CK -> N","VP -> B","CF -> S","FO -> V","VC -> S","BV -> V","NP -> P","SN -> C","KN -> V","NF -> P","SB -> C","PC -> B","OB -> V","NS -> O","FH -> S","NK -> S","HO -> V","NV -> O","FV -> O","FB -> S","PS -> S","FN -> K","HS -> O","CB -> K","HV -> P","NH -> C","BO -> B","FF -> N","PO -> F","BB -> N","PN -> C","BP -> C","HN -> K","CO -> P","BF -> H","BC -> S","CV -> B","VV -> F","FS -> B","BN -> P","VK -> S","PV -> V","PP -> B","PH -> N","SS -> O","SK -> S","NC -> P","ON -> F","NB -> N","CC -> N","SF -> H","PF -> H","OV -> O","KH -> C","CP -> V","PK -> O","KC -> K","KK -> C","KF -> B","HP -> C","FK -> H","BH -> K","VN -> H","OO -> S","SC -> K","SP -> B","KO -> V","KV -> F","HK -> N","FP -> N","NN -> B","VS -> O","HC -> K","BK -> N","KS -> K","VB -> O","OH -> F","KB -> F","KP -> H","HB -> N","NO -> N","OF -> O","BS -> H","VO -> H","SH -> O","SV -> K","HF -> C","CS -> F","FC -> N","VH -> H","OP -> K","OK -> H","PB -> K","HH -> S","OC -> V","VF -> B","CH -> K","CN -> C","SO -> P","OS -> O"]

@rules = []
INPUT.map do |i|
  pair, insertion = i.split(" -> ")
  hashy = { p: pair, i: insertion}
  @rules << hashy
end

@pairs = []
(PT.size-1).times do |t|
  @pairs << PT.slice(t,2)
end

@altered_polymer = PT.dup
@step_count = 0

4.times do
  @insertion_count = 0
  @new_polymer = @altered_polymer.dup
  @altered_polymer.each_char.with_index do |char, dex|
    next_dex = dex + 1
    next_char = @altered_polymer[next_dex]
    break if next_char == nil
    pair = char + next_char
    if @rules.any? { |r| r[:p] == pair }
      matchi = @rules.index { |r| r[:p] == pair }
      insertion = @rules[matchi][:i]
      @new_polymer.insert(next_dex + @insertion_count,insertion)
      @insertion_count +=1
    end
  end
  @altered_polymer = @new_polymer
  @step_count += 1
  puts "After step #{@step_count}: #{@altered_polymer}"
end

puts tally = @altered_polymer.each_char.tally
least = tally.values.min
most = tally.values.max
puts "most: #{most}"
puts "least: #{least}"
puts "most - least = #{most - least}"
