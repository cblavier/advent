defmodule Advent.Y2022.Day14.Part1 do
  def run(puzzle) do
    cave_map = build_map(puzzle)

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while(cave_map, fn i, cave_map ->
      case sand_pouring(cave_map, {500, 0}) do
        :void -> {:halt, i}
        cave_map -> {:cont, cave_map}
      end
    end)
  end

  def build_map(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.flat_map(fn line ->
      line
      |> String.split(" -> ")
      |> Enum.map(fn coords ->
        [x, y] = String.split(coords, ",")
        {String.to_integer(x), String.to_integer(y)}
      end)
      |> Enum.chunk_every(2, 1, :discard)
    end)
    |> Enum.reduce(%{}, fn [{start_x, start_y}, {end_x, end_y}], acc ->
      for x <- start_x..end_x, y <- start_y..end_y, reduce: acc do
        acc -> Map.put(acc, {x, y}, :rock)
      end
    end)
  end

  defp sand_pouring(cave_map, {x, y}) do
    cond do
      in_void?(cave_map, {x, y}) -> :void
      Map.get(cave_map, pos = {x, y + 1}) == nil -> sand_pouring(cave_map, pos)
      Map.get(cave_map, pos = {x - 1, y + 1}) == nil -> sand_pouring(cave_map, pos)
      Map.get(cave_map, pos = {x + 1, y + 1}) == nil -> sand_pouring(cave_map, pos)
      true -> Map.put(cave_map, {x, y}, :sand)
    end
  end

  defp in_void?(cave_map, {pos_x, pos_y}) do
    not Enum.any?(cave_map, fn {{x, y}, _} ->
      x == pos_x and y >= pos_y
    end)
  end
end
