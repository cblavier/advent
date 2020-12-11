defmodule Advent.Y2020.Day11Test do
  use ExUnit.Case
  doctest Advent.Y2020.Day11.Part1
  doctest Advent.Y2020.Day11.Part2

  alias Advent.Y2020.Day11.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 11)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 42
  end

  @tag :skip
  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 42
  end
end
