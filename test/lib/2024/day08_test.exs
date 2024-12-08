defmodule Advent.Y2024.Day08Test do
  use ExUnit.Case, async: true
  alias Advent.Y2024.Day08.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 08)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 305
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1150
  end
end
