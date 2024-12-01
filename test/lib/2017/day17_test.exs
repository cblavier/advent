defmodule Advent.Y2017.Day17Test do
  use ExUnit.Case
  alias Advent.Y2017.Day17.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 17)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 419
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 46_038_988
  end
end
