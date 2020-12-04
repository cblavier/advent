defmodule Advent.Y2020.Day04Test do
  use ExUnit.Case

  alias Advent.Y2020.Day04.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 4)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 219
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 127
  end
end
