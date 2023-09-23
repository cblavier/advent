defmodule Advent.Y2022.Day13Test do
  use ExUnit.Case
  alias Advent.Y2022.Day13.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 13)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 42
  end

  @tag :skip
  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 42
  end
end
