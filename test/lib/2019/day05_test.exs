defmodule Advent.Y2019.Day05Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day05

  alias Advent.Y2019.Day05

  @puzzle Advent.Puzzle.load(2019, 5)

  test "run part1 puzzle" do
    assert Day05.run(@puzzle, 1) |> take_result() == 13_210_611
  end

  test "run part2 puzzle" do
    assert Day05.run(@puzzle, 5) |> take_result() == 584_126
  end

  defp take_result(output) do
    output |> elem(1) |> Enum.at(-1)
  end
end
