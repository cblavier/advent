defmodule Advent.Y2020.Day19Test do
  use ExUnit.Case
  doctest Advent.Y2020.Day19.Part1
  doctest Advent.Y2020.Day19.Part2

  alias Advent.Y2020.Day19.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 19)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 149
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 332
  end
end
