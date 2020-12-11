defmodule Advent.Y2015.Day06Test do
  use ExUnit.Case

  alias Advent.Y2015.Day06.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 06)

  @tag :skip
  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 543_903
  end

  @tag :skip
  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 14_687_245
  end
end
