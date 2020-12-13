defmodule Advent.Y2020.Day13Test do
  use ExUnit.Case

  alias Advent.Y2020.Day13.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 13)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2045
  end

  @tag timeout: :infinity
  test "run part2 puzzle" do
    assert Part2.run("\n67,7,59,61") == 754_018
    assert Part2.run("\n67,7,59,61") == 754_018
    assert Part2.run("\n67,x,7,59,61") == 779_210
    assert Part2.run("\n67,7,x,59,61") == 1_261_476
    assert Part2.run("\n1789,37,47,1889") == 1_202_161_486
    assert Part2.run(@puzzle) == 402_251_700_208_309
  end
end
