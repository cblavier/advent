defmodule Advent.Y2022.Day06Test do
  use ExUnit.Case
  alias Advent.Y2022.Day06.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 06)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1287
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 3716
  end
end
