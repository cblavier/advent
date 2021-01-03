defmodule Advent.Y2015.Day07Test do
  use ExUnit.Case
  alias Advent.Y2015.Day07.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 07)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 16_076
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 2797
  end
end
