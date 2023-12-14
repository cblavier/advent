defmodule Advent.Y2023.Day03Test do
  use ExUnit.Case
  alias Advent.Y2023.Day03.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2023, 03)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 528_799
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 84_907_174
  end
end
