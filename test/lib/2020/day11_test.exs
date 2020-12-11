defmodule Advent.Y2020.Day11Test do
  use ExUnit.Case

  alias Advent.Y2020.Day11.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 11)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2270
  end

  @tag :skip
  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 2042
  end
end
