defmodule Advent.Y2018.Day05Test do
  use ExUnit.Case
  doctest Advent.Y2018.Day05.Part1

  alias Advent.Y2018.Day05.{Part1}

  @puzzle Advent.Puzzle.load(2018, 5)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle, chunk_size: 2000) == 10_762
  end

  # test "run part2 puzzle" do
  #   assert Part2.run(@puzzle) == {191, 26}
  # end
end
