defmodule Advent.Y2022.Day12Test do
  use ExUnit.Case
  alias Advent.Y2022.Day12.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 12)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 437
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 430
  end
end
