defmodule Advent.Y2022.Day16Test do
  use ExUnit.Case
  alias Advent.Y2022.Day16.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 16)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1845
  end

  @tag :skip
  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 42
  end
end
