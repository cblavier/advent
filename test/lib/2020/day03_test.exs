defmodule Advent.Y2020.Day03Test do
  use ExUnit.Case
  doctest Advent.Y2020.Day03.Part1
  doctest Advent.Y2020.Day03.Part2

  alias Advent.Y2020.Day03.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 3)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 187
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 4_723_283_400
  end
end
