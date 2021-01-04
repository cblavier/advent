defmodule Advent.Y2015.Day09Test do
  use ExUnit.Case
  alias Advent.Y2015.Day09.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 09)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 207
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 804
  end
end
