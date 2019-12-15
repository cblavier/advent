defmodule Advent.Y2019.Day09Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day09

  alias Advent.Y2019.Day09

  @puzzle Advent.Puzzle.load(2019, 9)

  test "run part1 puzzle" do
    assert Day09.run(@puzzle, 1) |> elem(1) == [4_261_108_180]
  end

  test "run part2 puzzle" do
    assert Day09.run(@puzzle, 2) |> elem(1) == [77_944]
  end
end
