defmodule Advent.Y2024.Day02Test do
  use ExUnit.Case, async: true
  alias Advent.Y2024.Day02.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 02)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 598
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 634
  end
end
