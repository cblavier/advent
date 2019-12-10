defmodule Advent.Y2019.Day06Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day06.Part1
  doctest Advent.Y2019.Day06.Part2

  alias Advent.Y2019.Day06.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2019, 6)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 300_598
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 520
  end
end
