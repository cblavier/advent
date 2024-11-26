defmodule Advent.Y2017.Day06Test do
  use ExUnit.Case
  alias Advent.Y2017.Day06.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 06)

  test "run part1 puzzle" do
    assert Part1.run("0 2 7 0") == 5
    assert Part1.run(@puzzle) == 11137
  end

  test "run part2 puzzle" do
    assert Part2.run("0 2 7 0") == 4
    assert Part2.run(@puzzle) == 1037
  end
end
