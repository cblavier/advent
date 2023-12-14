defmodule Advent.Y2023.Day02Test do
  use ExUnit.Case
  alias Advent.Y2023.Day02.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2023, 02)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2285
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 77021
  end
end
