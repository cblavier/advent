defmodule Advent.Y2017.Day19Test do
  use ExUnit.Case
  alias Advent.Y2017.Day19.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 19)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == "LOHMDQATP"
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 16_492
  end
end
