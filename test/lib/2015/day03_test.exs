defmodule Advent.Y2015.Day03Test do
  use ExUnit.Case

  alias Advent.Y2015.Day03.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 3)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2572
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 2631
  end
end
