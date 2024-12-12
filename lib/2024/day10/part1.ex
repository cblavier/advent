defmodule Advent.Y2024.Day10.Part1 do
  import Enum

  def run(puzzle) do
    map = parse(puzzle)
    map |> find_zeros() |> map(&hike(map, &1)) |> map(&elem(&1, 0)) |> sum()
  end

  def parse(puzzle) do
    for {row, y} <- puzzle |> String.split("\n") |> with_index(),
        {height, x} <- row |> String.graphemes() |> with_index(),
        into: %{},
        do: {{x, y}, String.to_integer(height)}
  end

  def find_zeros(map), do: for({{x, y}, h} <- map, h == 0, do: {x, y})

  defp hike(map, pos, height \\ 0, visited \\ MapSet.new())
  defp hike(_map, pos, 9, visited), do: {1, MapSet.put(visited, pos)}

  defp hike(map, pos, height, visited) do
    visited = MapSet.put(visited, pos)

    case neighbours(map, pos, height, visited) do
      [] ->
        {0, visited}

      neighbours ->
        for {n, h} <- neighbours, reduce: {0, visited} do
          {total, visited} ->
            {score, visited} = hike(map, n, h, visited)
            {total + score, visited}
        end
    end
  end

  defp neighbours(map, {x, y}, height, visited) do
    for {dx, dy} <- [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
        {nx, ny} = {x + dx, y + dy},
        not MapSet.member?(visited, {nx, ny}),
        new_height = Map.get(map, {nx, ny}, -1),
        new_height == height + 1,
        do: {{nx, ny}, new_height}
  end
end
