defmodule Advent.Y2017.Day05Test do
  use ExUnit.Case
  alias Advent.Y2017.Day05.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 05)

  test "run part1 puzzle" do
    assert Part1.run("0 3 0 1 -3") == 5
    assert Part1.run(@puzzle) == 325_922
  end

  test "run part2 puzzle" do
    assert Part2.run("0 3 0 1 -3") == 10
    assert Part2.run(@puzzle) == 24_490_906
  end
end
