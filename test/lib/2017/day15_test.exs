defmodule Advent.Y2017.Day15Test do
  use ExUnit.Case
  alias Advent.Y2017.Day15.{Part1, Part2}

  @a 883
  @b 879

  test "run part1 puzzle" do
    assert Part1.run(@a, @b) == 609
  end

  test "run part2 puzzle" do
    assert Part2.run(@a, @b) == 253
  end
end
