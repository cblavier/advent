defmodule Advent.Y2023.Day01Test do
  use ExUnit.Case
  alias Advent.Y2023.Day01.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2023, 01)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 53386
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 53312
  end
end
