defmodule Advent.Y2024.Day01Test do
  use ExUnit.Case
  alias Advent.Y2024.Day01.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 01)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2_378_066
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 18_934_359
  end
end