defmodule Advent.Y2015.Day20Test do
  use ExUnit.Case
  alias Advent.Y2015.Day20.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2015, 20)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 786_240
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 831_600
  end
end
