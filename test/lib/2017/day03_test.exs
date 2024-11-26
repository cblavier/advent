defmodule Advent.Y2017.Day03Test do
  use ExUnit.Case
  alias Advent.Y2017.Day03.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 03)

  test "run part1 puzzle" do
    assert Part1.run("1") == 0
    assert Part1.run("12") == 3
    assert Part1.run("23") == 2
    assert Part1.run("1024") == 31
    assert Part1.run("368078") == 371
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 369_601
  end
end
