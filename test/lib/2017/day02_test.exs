defmodule Advent.Y2017.Day02Test do
  use ExUnit.Case
  alias Advent.Y2017.Day02.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 02)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 53_978
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 314
  end
end
