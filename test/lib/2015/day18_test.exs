defmodule Advent.Y2015.Day18Test do
  use ExUnit.Case
  alias Advent.Y2015.Day18.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 18)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 768
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 781
  end
end
