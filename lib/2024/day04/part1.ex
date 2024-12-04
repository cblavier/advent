defmodule Advent.Y2024.Day04.Part1 do
  def run(puzzle) do
    grid = parse(puzzle)

    grid
    |> find_char("X")
    |> Enum.map(fn pos ->
      pos |> directions() |> Enum.count(&(multiple_get(grid, &1) == "MAS"))
    end)
    |> Enum.sum()
  end

  def parse(puzzle) do
    for {row, y} <- puzzle |> String.split("\n") |> Enum.with_index(),
        {char, x} <- row |> String.graphemes() |> Enum.with_index(),
        into: %{},
        do: {{x, y}, char}
  end

  def find_char(grid, match) do
    grid |> Enum.filter(fn {_, c} -> c == match end) |> Enum.map(&elem(&1, 0))
  end

  def directions({x, y}) do
    [
      [{x + 1, y}, {x + 2, y}, {x + 3, y}],
      [{x - 1, y}, {x - 2, y}, {x - 3, y}],
      [{x, y + 1}, {x, y + 2}, {x, y + 3}],
      [{x, y - 1}, {x, y - 2}, {x, y - 3}],
      [{x + 1, y + 1}, {x + 2, y + 2}, {x + 3, y + 3}],
      [{x - 1, y - 1}, {x - 2, y - 2}, {x - 3, y - 3}],
      [{x - 1, y + 1}, {x - 2, y + 2}, {x - 3, y + 3}],
      [{x + 1, y - 1}, {x + 2, y - 2}, {x + 3, y - 3}]
    ]
  end

  def multiple_get(grid, positions) do
    Enum.map_join(positions, &Map.get(grid, &1))
  end
end
