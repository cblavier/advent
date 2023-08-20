defmodule Advent.Y2022.Day01Test do
  use ExUnit.Case
  alias Advent.Y2022.Day01.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 01)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 69_693
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 200_945
  end
end
