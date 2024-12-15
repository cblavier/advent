defmodule Advent.Y2024.Day12Test do
  use ExUnit.Case
  alias Advent.Y2024.Day12.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 12)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1_402_544
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 862_486
  end
end
