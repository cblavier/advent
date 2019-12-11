defmodule Advent.Y2019.Day11Test do
  use ExUnit.Case
  doctest Advent.Y2019.Day11

  alias Advent.Y2019.Day11

  @puzzle Advent.Puzzle.load(2019, 11)

  test "run part1 puzzle" do
    assert Day11.run(@puzzle, 0) |> elem(1) == 2064
  end

  test "run part2 puzzle" do
    {hull, _} = Day11.run(@puzzle, 1)
    max_x = hull |> Map.keys() |> Enum.max_by(&elem(&1, 0)) |> elem(0)
    max_y = hull |> Map.keys() |> Enum.max_by(&elem(&1, 1)) |> elem(1)
    print_hull(hull, max_x, max_y)
  end

  defp print_hull(hull, width, height) do
    for y <- 0..height do
      for x <- 0..width, into: "" do
        case Map.get(hull, {x, y}) do
          nil -> " "
          0 -> " "
          1 -> "#"
        end
      end

      # |> IO.puts()
    end
  end
end
