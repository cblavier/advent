defmodule Advent.Y2022.Day04Test do
  use ExUnit.Case
  alias Advent.Y2022.Day04.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 04)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 503
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 827
  end
end
