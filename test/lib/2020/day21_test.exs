defmodule Advent.Y2020.Day21Test do
  use ExUnit.Case
  alias Advent.Y2020.Day21.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2020, 21)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 2573
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == "bjpkhx,nsnqf,snhph,zmfqpn,qrbnjtj,dbhfd,thn,sthnsg"
  end
end
