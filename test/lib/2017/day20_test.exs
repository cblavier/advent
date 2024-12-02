defmodule Advent.Y2017.Day20Test do
  use ExUnit.Case
  alias Advent.Y2017.Day20.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 20)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 258
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 707
  end
end
