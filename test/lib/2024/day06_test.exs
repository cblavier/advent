defmodule Advent.Y2024.Day06Test do
  use ExUnit.Case, async: true
  alias Advent.Y2024.Day06.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 06)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 4789
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1304
  end
end
