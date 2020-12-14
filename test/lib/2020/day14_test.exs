defmodule Advent.Y2020.Day14Test do
  use ExUnit.Case
  doctest Advent.Y2020.Day14.Part2

  alias Advent.Y2020.Day14.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 14)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 11_612_740_949_946
  end

  test "run part2 puzzle" do
    assert Part2.find_addresses(42, "000000000000000000000000000000X1001X") ==
             [26, 27, 58, 59]

    # assert Part2.run(@puzzle) == 3_394_509_207_186
  end
end
