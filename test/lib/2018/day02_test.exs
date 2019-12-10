defmodule Advent.Y2018.Day02Test do
  use ExUnit.Case
  doctest Advent.Y2018.Day02.Part1
  doctest Advent.Y2018.Day02.Part2

  alias Advent.Y2018.Day02.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2018, 2)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 7_163
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == "ighfbyijnoumxjlxevacpwqtr"
  end
end
