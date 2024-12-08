defmodule Advent.Y2024.Day04Test do
  use ExUnit.Case, async: true
  alias Advent.Y2024.Day04.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 04)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2462
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1877
  end
end
