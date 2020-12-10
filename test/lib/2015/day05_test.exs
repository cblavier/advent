defmodule Advent.Y2015.Day05Test do
  use ExUnit.Case

  alias Advent.Y2015.Day05.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 5)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 236
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 51
  end
end
