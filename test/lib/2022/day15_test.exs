defmodule Advent.Y2022.Day15Test do
  use ExUnit.Case, async: true
  alias Advent.Y2022.Day15.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 15)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 4_811_413
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 13_171_855_019_123
  end
end
