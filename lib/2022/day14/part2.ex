defmodule Advent.Y2022.Day14.Part2 do
  import Advent.Y2022.Day14.Part1

  def run(puzzle) do
    cave_map = build_map(puzzle)
    floor = find_floor(cave_map)
    origin = {500, 0}

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(cave_map, fn i, cave_map ->
      cave_map = sand_pouring(cave_map, origin, floor)

      if Map.get(cave_map, origin) == :sand do
        {:halt, i}
      else
        {:cont, cave_map}
      end
    end)
  end

  defp find_floor(cave_map) do
    (cave_map |> Map.keys() |> Enum.map(&elem(&1, 1)) |> Enum.max()) + 2
  end

  defp sand_pouring(cave_map, {x, y}, floor) do
    cond do
      y + 1 == floor -> Map.put(cave_map, {x, y}, :sand)
      Map.get(cave_map, pos = {x, y + 1}) == nil -> sand_pouring(cave_map, pos, floor)
      Map.get(cave_map, pos = {x - 1, y + 1}) == nil -> sand_pouring(cave_map, pos, floor)
      Map.get(cave_map, pos = {x + 1, y + 1}) == nil -> sand_pouring(cave_map, pos, floor)
      true -> Map.put(cave_map, {x, y}, :sand)
    end
  end
end
