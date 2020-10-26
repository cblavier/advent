defmodule Advent.Y2018.Day05Test do
  use ExUnit.Case
  doctest Advent.Y2018.Day05.Part1

  alias Advent.Y2018.Day05.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2018, 5)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 10_762
  end

  @tag timeout: :infinity
  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 6946
  end
end
