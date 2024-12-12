defmodule Advent.Y2024.Day10.Part2 do
  alias Advent.Y2024.Day10.Part1

  def run(puzzle) do
    map = Part1.parse(puzzle)
    map |> Part1.find_zeros() |> Enum.map(&hike(map, &1, 0)) |> Enum.sum()
  end

  defp hike(_map, _pos, 9), do: 1

  defp hike(map, pos, height) do
    case neighbours(map, pos, height) do
      [] -> 0
      ns -> ns |> Enum.map(fn {pos, h} -> hike(map, pos, h) end) |> Enum.sum()
    end
  end

  defp neighbours(map, {x, y}, height) do
    for {dx, dy} <- [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
        {nx, ny} = {x + dx, y + dy},
        new_height = Map.get(map, {nx, ny}, -1),
        new_height == height + 1,
        do: {{nx, ny}, new_height}
  end
end
