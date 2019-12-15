defmodule Advent.Y2019.Day15Test do
  use ExUnit.Case

  alias Advent.Y2019.Day15.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2019, 15)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) |> elem(2) == 294
  end

  test "run part2 puzzle" do
    Advent.Benchmark.measure(fn ->
      assert Part2.run(@puzzle) == 388
    end)
  end
end
