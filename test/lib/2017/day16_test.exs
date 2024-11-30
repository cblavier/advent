defmodule Advent.Y2017.Day16Test do
  use ExUnit.Case
  alias Advent.Y2017.Day16.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 16)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == "jcobhadfnmpkglie"
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == "pclhmengojfdkaib"
  end
end
