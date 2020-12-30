defmodule Advent.Y2020.Day20Test do
  use ExUnit.Case

  alias Advent.Y2020.Day20.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 20)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 15_405_893_262_491
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 2133
  end
end
