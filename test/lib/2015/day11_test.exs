defmodule Advent.Y2015.Day11Test do
  use ExUnit.Case
  alias Advent.Y2015.Day11.Part1

  @puzzle Advent.Puzzle.load(2015, 11)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == "vzbxxyzz"
  end

  test "run part2 puzzle" do
    assert Part1.run("vzbxxyzz") == "vzcaabcc"
  end
end
