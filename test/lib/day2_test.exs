defmodule Advent2019.Day2Test do
  use ExUnit.Case
  doctest Advent2019.Day2.Part1
  doctest Advent2019.Day2.Part2

  alias Advent2019.Day2.{Part1, Part2}

  @puzzle_path Path.expand("../fixtures/day2/puzzle.txt", __DIR__)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle_path) == 3_101_844
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle_path, 19_690_720) == 8_478
  end
end
