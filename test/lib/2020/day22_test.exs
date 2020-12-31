defmodule Advent.Y2020.Day22Test do
  use ExUnit.Case
  alias Advent.Y2020.Day22.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 22)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 34_324
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 33_259
  end
end
