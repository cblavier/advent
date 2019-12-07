defmodule Advent.Y2019.Day7Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day7.Part1
  doctest Advent.Y2019.Day7.Part2

  alias Advent.Y2019.Day7.{Part1, Part2}

  @puzzle_path Advent.Puzzle.path(2019, 7)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle_path) == 255_590
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle_path) == 58_285_150
  end
end
