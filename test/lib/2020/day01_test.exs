defmodule Advent.Y2020.Day01Test do
  use ExUnit.Case
  doctest Advent.Y2020.Day01.Part1
  doctest Advent.Y2020.Day01.Part2

  alias Advent.Y2020.Day01.Part1
  alias Advent.Y2020.Day01.Part2

  @puzzle Advent.Puzzle.load(2020, 1)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 1_016_619
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 218_767_230
  end
end
