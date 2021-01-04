defmodule Advent.Y2015.Day08Test do
  use ExUnit.Case
  alias Advent.Y2015.Day08.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 08)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1371
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 2117
  end
end
