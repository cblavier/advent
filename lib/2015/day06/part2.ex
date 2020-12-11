defmodule Advent.Y2015.Day06.Part2 do
  alias Advent.Y2015.Day06.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&Part1.parse_line/1)
    |> Enum.reduce(%{}, &apply_instruction(&1, &2))
    |> Enum.map(fn {_, brightness} -> brightness end)
    |> Enum.sum()
  end

  def apply_instruction({instruction, {x1, y1}, {x2, y2}}, grid) do
    all_positions = for x <- x1..x2, y <- y1..y2, into: [], do: {x, y}

    Enum.reduce(all_positions, grid, fn {x, y}, grid ->
      case instruction do
        "turn on" -> Map.update(grid, {x, y}, 1, &(&1 + 1))
        "turn off" -> Map.update(grid, {x, y}, 0, &max(0, &1 - 1))
        "toggle" -> Map.update(grid, {x, y}, 2, &(&1 + 2))
      end
    end)
  end
end
