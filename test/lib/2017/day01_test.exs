defmodule Advent.Y2017.Day01Test do
  use ExUnit.Case
  alias Advent.Y2017.Day01.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 01)

  test "run part1 puzzle" do
    assert Part1.run("1122") == 3
    assert Part1.run("1111") == 4
    assert Part1.run("1234") == 0
    assert Part1.run("91212129") == 9
    assert Part1.run(@puzzle) == 1029
  end

  test "run part2 puzzle" do
    assert Part2.run("1212") == 6
    assert Part2.run("1221") == 0
    assert Part2.run("123425") == 4
    assert Part2.run("123123") == 12
    assert Part2.run("12131415") == 4
    assert Part2.run(@puzzle) == 1220
  end
end
