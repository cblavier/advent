defmodule Advent.Y2024.Day05Test do
  use ExUnit.Case, async: true
  alias Advent.Y2024.Day05.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 05)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 4790
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 6319
  end
end
