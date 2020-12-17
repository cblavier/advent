defmodule Advent.Y2020.Day17Test do
  use ExUnit.Case
  doctest Advent.Y2020.Day17.Part1
  doctest Advent.Y2020.Day17.Part2

  alias Advent.Y2020.Day17.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 17)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 215
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1728
  end
end
