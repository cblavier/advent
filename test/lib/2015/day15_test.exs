defmodule Advent.Y2015.Day15Test do
  use ExUnit.Case
  alias Advent.Y2015.Day15.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 15)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 21_367_368
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 1_766_400
  end
end
