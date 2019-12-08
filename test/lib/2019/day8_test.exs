defmodule Advent.Y2019.Day8Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day8.Part1
  doctest Advent.Y2019.Day8.Part2

  alias Advent.Y2019.Day8.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2019, 8)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2760
  end

  test "run part2 puzzle" do
    r = []
    r = r ++ ~w(0 1 1 0 0 0 1 1 0 0 1 0 0 1 0 1 1 1 1 0 1 1 1 0 0)
    r = r ++ ~w(1 0 0 1 0 1 0 0 1 0 1 0 0 1 0 1 0 0 0 0 1 0 0 1 0)
    r = r ++ ~w(1 0 0 1 0 1 0 0 0 0 1 0 0 1 0 1 1 1 0 0 1 1 1 0 0)
    r = r ++ ~w(1 1 1 1 0 1 0 1 1 0 1 0 0 1 0 1 0 0 0 0 1 0 0 1 0)
    r = r ++ ~w(1 0 0 1 0 1 0 0 1 0 1 0 0 1 0 1 0 0 0 0 1 0 0 1 0)
    r = r ++ ~w(1 0 0 1 0 0 1 1 1 0 0 1 1 0 0 1 1 1 1 0 1 1 1 0 0)
    assert Part2.run(@puzzle) == r
  end
end
