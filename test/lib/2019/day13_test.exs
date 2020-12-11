defmodule Advent.Y2019.Day13Test do
  use ExUnit.Case

  alias Advent.Y2019.Day13.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2019, 13)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 216
  end

  @tag :skip
  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 10_025
  end
end
