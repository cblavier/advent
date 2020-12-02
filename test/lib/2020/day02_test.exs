defmodule Advent.Y2020.Day02Test do
  use ExUnit.Case
  doctest Advent.Y2020.Day02.Part1
  doctest Advent.Y2020.Day02.Part2

  alias Advent.Y2020.Day02.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 2)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 456
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 308
  end
end
