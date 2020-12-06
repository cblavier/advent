defmodule Advent.Y2020.Day06Test do
  use ExUnit.Case

  alias Advent.Y2020.Day06.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 6)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 6596
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 3219
  end
end
