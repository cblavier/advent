defmodule Advent.Y2019.Day6Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day6.Part1
  doctest Advent.Y2019.Day6.Part2

  alias Advent.Y2019.Day6.{Part1, Part2}

  @puzzle_path Advent.Puzzle.path(2019, 6)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle_path) == 300_598
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle_path) == 520
  end
end
