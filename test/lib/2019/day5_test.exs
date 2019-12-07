defmodule Advent.Y2019.Day5Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day5

  alias Advent.Y2019.Day5

  @puzzle Advent.Puzzle.load(2019, 5)

  test "run part1 puzzle" do
    assert Day5.run(@puzzle, ["1"]) == 13_210_611
  end

  test "run part2 puzzle" do
    assert Day5.run(@puzzle, ["5"]) == 584_126
  end
end
