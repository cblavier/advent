defmodule Advent2019.Day1Test do
  use ExUnit.Case
  doctest Advent2019.Day1.Part1
  doctest Advent2019.Day1.Part2

  alias Advent2019.Day1.{Part1, Part2}

  @puzzle_path Path.expand("../fixtures/day1/puzzle.txt", __DIR__)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle_path) == 3_495_189
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle_path) == 5_239_910
  end
end
