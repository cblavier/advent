defmodule Advent.Y2019.Day9Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day9

  alias Advent.Y2019.Day9

  @puzzle Advent.Puzzle.load(2019, 9)

  test "run part1 puzzle" do
    assert Day9.run(@puzzle, 1) == [4_261_108_180]
  end

  test "run part2 puzzle" do
    assert Day9.run(@puzzle, 2) == [77_944]
  end
end
