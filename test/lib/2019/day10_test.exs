defmodule Advent.Y2019.Day10Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day10.Part1
  doctest Advent.Y2019.Day10.Part2

  alias Advent.Y2019.Day10.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2019, 10)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == {{31, 20}, 319}
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle, {31, 20}, 200) == 517
  end
end
