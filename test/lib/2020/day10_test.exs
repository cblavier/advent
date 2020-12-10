defmodule Advent.Y2020.Day10Test do
  use ExUnit.Case
  doctest Advent.Y2020.Day10.Part1
  doctest Advent.Y2020.Day10.Part2

  alias Advent.Y2020.Day10.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 10)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2738
  end

  @tag timeout: :infinity
  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 74_049_191_673_856
  end
end
