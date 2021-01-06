defmodule Advent.Y2015.Day16Test do
  use ExUnit.Case
  alias Advent.Y2015.Day16.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 16)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == "Sue 40"
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == "Sue 241"
  end
end
