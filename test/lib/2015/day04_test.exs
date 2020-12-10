defmodule Advent.Y2015.Day04Test do
  use ExUnit.Case
  doctest Advent.Y2015.Day04.Part1
  doctest Advent.Y2015.Day04.Part2

  alias Advent.Y2015.Day04.{Part1, Part2}

  @puzzle "yzbqklnj"

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 282_749
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == 9_962_624
  end
end
