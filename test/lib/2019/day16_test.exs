defmodule Advent.Y2019.Day16Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day16.Part1

  alias Advent.Y2019.Day16.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2019, 16)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle, 100) == 74_608_727
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle, 100) == 57_920_757
  end
end
