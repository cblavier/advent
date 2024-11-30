defmodule Advent.Y2017.Day14Test do
  use ExUnit.Case
  alias Advent.Y2017.Day14.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 14)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 8140
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1182
  end
end
