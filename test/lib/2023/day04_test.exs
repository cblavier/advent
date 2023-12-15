defmodule Advent.Y2023.Day04Test do
  use ExUnit.Case
  alias Advent.Y2023.Day04.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2023, 04)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 23441
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 5_923_918
  end
end
