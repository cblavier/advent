defmodule Advent.Y2022.Day08Test do
  use ExUnit.Case
  alias Advent.Y2022.Day08.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 08)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1785
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 345_168
  end
end
