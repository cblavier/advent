defmodule Advent.Y2017.Day10Test do
  use ExUnit.Case
  alias Advent.Y2017.Day10.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 10)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 38415
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == "9de8846431eef262be78f590e39a4848"
  end
end
