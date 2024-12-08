defmodule Advent.Y2024.Day07Test do
  use ExUnit.Case, async: true
  alias Advent.Y2024.Day07.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2024, 07)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 66_343_330_034_722
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 637_696_070_419_031
  end
end
