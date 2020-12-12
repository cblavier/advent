defmodule Advent.Y2020.Day12Test do
  use ExUnit.Case
  alias Advent.Y2020.Day12.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 12)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1631
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 58606
  end
end
