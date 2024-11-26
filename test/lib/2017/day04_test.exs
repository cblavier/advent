defmodule Advent.Y2017.Day04Test do
  use ExUnit.Case
  alias Advent.Y2017.Day04.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 04)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 451
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 223
  end
end
