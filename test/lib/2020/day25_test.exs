defmodule Advent.Y2020.Day25Test do
  use ExUnit.Case
  alias Advent.Y2020.Day25.Part1

  @puzzle Advent.Puzzle.load(2020, 25)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 9_420_461
  end
end
