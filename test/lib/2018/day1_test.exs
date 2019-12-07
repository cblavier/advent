defmodule Advent.Y2018.Day1Test do
  use ExUnit.Case
  doctest Advent.Y2018.Day1.Part1
  doctest Advent.Y2018.Day1.Part2

  alias Advent.Y2018.Day1.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2018, 1)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 520
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 394
  end
end
