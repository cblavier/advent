defmodule Advent.Y2022.Day14Test do
  use ExUnit.Case
  alias Advent.Y2022.Day14.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 14)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 805
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 25_161
  end
end
