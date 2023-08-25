defmodule Advent.Y2022.Day05Test do
  use ExUnit.Case
  alias Advent.Y2022.Day05.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 05)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == "QNNTGTPFN"
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == "GGNPJBTTR"
  end
end
