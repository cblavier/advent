defmodule Advent.Y2015.Day14Test do
  use ExUnit.Case
  alias Advent.Y2015.Day14.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 14)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2640
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1102
  end
end
