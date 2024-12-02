defmodule Advent.Y2017.Day18Test do
  use ExUnit.Case
  alias Advent.Y2017.Day18.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 18)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 7071
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 8001
  end
end
