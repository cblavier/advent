defmodule Advent.Y2015.Day17Test do
  use ExUnit.Case
  alias Advent.Y2015.Day17.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 17)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 42
  end

  @tag :skip
  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 42
  end
end
