defmodule Advent.Y2022.Day03Test do
  use ExUnit.Case
  alias Advent.Y2022.Day03.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 03)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 8202
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 2864
  end
end
