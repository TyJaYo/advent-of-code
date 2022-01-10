#!/usr/bin/env ruby

INPUT = ["5483143223","2745854711","5264556173","6141336146","6357385478","4167524645","2176841721","6882881134","4846848554","5283751526"]
INPUT2 = ["5283751526", "4846848554", "6882881134", "2176841721", "4167524645", "6357385478", "6141336146", "5264556173", "2745854711", "5483143223"]

# --- Part One ---

# --- Part Two ---
CSI = "\e["

$stdout.write "#{CSI}2J"    # clear screen
$stdout.write "#{CSI}1;1H"  # move to top left corner
$stdout.write "#{CSI}s"     # save cursor position
$stdout.puts INPUT2
sleep(1)
$stdout.write "#{CSI}u"     # restore cursor position
$stdout.puts INPUT
sleep(1)
