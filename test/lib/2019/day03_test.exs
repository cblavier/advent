defmodule Advent.Y2019.Day03Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day03.Part1
  doctest Advent.Y2019.Day03.Part2

  alias Advent.Y2019.Day03.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2019, 3)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2_193
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 63_526
  end
end
