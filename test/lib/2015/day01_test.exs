defmodule Advent.Y2015.Day01Test do
  use ExUnit.Case

  alias Advent.Y2015.Day01.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 1)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 138
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1771
  end
end
