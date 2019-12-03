defmodule Advent.Y2019.Day3Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day3.Part1
  doctest Advent.Y2019.Day3.Part2

  alias Advent.Y2019.Day3.{Part1, Part2}

  @puzzle_path Advent.Puzzle.path(2019, 3)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle_path) == 2_193
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle_path) == 63_526
  end
end
