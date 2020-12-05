defmodule Advent.Y2020.Day05Test do
  use ExUnit.Case

  doctest Advent.Y2020.Day05.Part1
  alias Advent.Y2020.Day05.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 5)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 901
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 661
  end
end
