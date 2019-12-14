defmodule Advent.Y2019.Day14Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day14.Part1
  doctest Advent.Y2019.Day14.Part2

  alias Advent.Y2019.Day14.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2019, 14)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) |> elem(0) == %{"ORE" => 216_477}
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle, 1_000_000_000_000) == 11_788_286
  end
end
