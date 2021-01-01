defmodule Advent.Y2020.Day23Test do
  use ExUnit.Case
  alias Advent.Y2020.Day23.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 23)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == "45286397"
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 42
  end
end
