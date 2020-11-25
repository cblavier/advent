defmodule Advent.Y2018.Day07Test do
  use ExUnit.Case
  doctest Advent.Y2018.Day07.Part1
  doctest Advent.Y2018.Day07.Part2

  alias Advent.Y2018.Day07.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2018, 7)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == "JMQZELVYXTIGPHFNSOADKWBRUC"
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle, 5, 60) == 1133
  end
end
