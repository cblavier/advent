defmodule Advent.Y2020.Day09Test do
  use ExUnit.Case

  alias Advent.Y2020.Day09.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 9)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 25_918_798
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 3_340_942
  end
end
