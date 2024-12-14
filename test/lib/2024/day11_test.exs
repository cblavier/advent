defmodule Advent.Y2024.Day11Test do
  use ExUnit.Case
  alias Advent.Y2024.Day11.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 11)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 184_927
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 220_357_186_726_677
  end
end
