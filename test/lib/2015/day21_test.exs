defmodule Advent.Y2015.Day21Test do
  use ExUnit.Case
  alias Advent.Y2015.Day21.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 21)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 91
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 158
  end
end
