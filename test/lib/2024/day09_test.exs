defmodule Advent.Y2024.Day09Test do
  use ExUnit.Case
  alias Advent.Y2024.Day09.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 09)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 6_283_170_117_911
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 6_307_653_242_596
  end
end
