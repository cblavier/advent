defmodule Advent.Y2022.Day02Test do
  use ExUnit.Case
  alias Advent.Y2022.Day02.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 02)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 13_268
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 15_508
  end
end
