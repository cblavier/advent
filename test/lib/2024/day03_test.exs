defmodule Advent.Y2024.Day03Test do
  use ExUnit.Case, async: true
  alias Advent.Y2024.Day03.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 03)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 191_183_308
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 92_082_041
  end
end
