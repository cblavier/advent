defmodule Advent.Y2017.Day12Test do
  use ExUnit.Case
  alias Advent.Y2017.Day12.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 12)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 380
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 181
  end
end
