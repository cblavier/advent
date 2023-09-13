defmodule Advent.Y2022.Day11Test do
  use ExUnit.Case
  alias Advent.Y2022.Day11.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 11)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 76_728
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 21_553_910_156
  end
end
