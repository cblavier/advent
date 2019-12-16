defmodule Advent.Y2015.Day02Test do
  use ExUnit.Case

  alias Advent.Y2015.Day02.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 2)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1_586_300
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 3_737_498
  end
end
