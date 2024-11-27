defmodule Advent.Y2017.Day08Test do
  use ExUnit.Case
  alias Advent.Y2017.Day08.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 08)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 6611
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 6619
  end
end
