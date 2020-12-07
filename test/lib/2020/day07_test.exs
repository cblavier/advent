defmodule Advent.Y2020.Day07Test do
  use ExUnit.Case

  doctest Advent.Y2020.Day07.Part1
  alias Advent.Y2020.Day07.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 7)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 235
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 158_493
  end
end
