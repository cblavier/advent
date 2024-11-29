defmodule Advent.Y2017.Day13Test do
  use ExUnit.Case
  alias Advent.Y2017.Day13.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 13)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1728
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 3_946_838
  end
end
