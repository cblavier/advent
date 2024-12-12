defmodule Advent.Y2024.Day10Test do
  use ExUnit.Case
  alias Advent.Y2024.Day10.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 10)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 468
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 966
  end
end
