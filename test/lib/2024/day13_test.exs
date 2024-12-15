defmodule Advent.Y2024.Day13Test do
  use ExUnit.Case
  alias Advent.Y2024.Day13.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 13)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 29388
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 99_548_032_866_004
  end
end
