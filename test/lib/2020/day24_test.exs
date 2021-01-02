defmodule Advent.Y2020.Day24Test do
  use ExUnit.Case
  alias Advent.Y2020.Day24.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 24)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 254
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 3697
  end
end
