defmodule Advent.Y2017.Day11Test do
  use ExUnit.Case
  alias Advent.Y2017.Day11.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 11)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 877
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1622
  end
end
