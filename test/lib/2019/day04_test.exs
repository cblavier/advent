defmodule Advent.Y2019.Day04Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day04.Part1
  doctest Advent.Y2019.Day04.Part2

  alias Advent.Y2019.Day04.{Part1, Part2}

  test "run part1 puzzle" do
    assert Part1.run(265_275, 781_584) == 960
  end

  test "run part2 puzzle" do
    assert Part2.run(265_275, 781_584) == 626
  end
end
