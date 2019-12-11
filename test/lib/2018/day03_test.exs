defmodule Advent.Y2018.Day03Test do
  use ExUnit.Case

  alias Advent.Y2018.Day03.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2018, 3)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 105_047
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 658
  end
end
