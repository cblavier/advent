defmodule Advent.Y2020.Day15Test do
  use ExUnit.Case
  doctest Advent.Y2020.Day15.Part1

  alias Advent.Y2020.Day15.Part1

  @puzzle Advent.Puzzle.load(2020, 15)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle, 2020) == 1111
  end

  @tag :skip
  test "run part2 puzzle" do
    assert Part1.run(@puzzle, 30_000_000) == 48_568
  end
end
