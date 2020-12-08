defmodule Advent.Y2020.Day08Test do
  use ExUnit.Case

  alias Advent.Y2020.Day08.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 8)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1394
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1626
  end
end
