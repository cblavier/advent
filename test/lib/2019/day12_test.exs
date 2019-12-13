defmodule Advent.Y2019.Day12Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day12.Part1

  alias Advent.Y2019.Day12.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2019, 12)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle, 1000) |> elem(1) == 12_773
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 12
  end
end
