defmodule Advent.Y2015.Day12Test do
  use ExUnit.Case
  alias Advent.Y2015.Day12.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 12)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 191_164
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 87842
  end
end
