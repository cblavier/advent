defmodule Advent.Y2017.Day07Test do
  use ExUnit.Case
  alias Advent.Y2017.Day07.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 07)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == "bpvhwhh"
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 256
  end
end
