defmodule Advent.Y2022.Day12.Part2 do
  import Advent.Y2022.Day12.Part1

  @distance_to_beat 432
  def run(puzzle) do
    map = parse_map(puzzle)
    end_cell = find_cell(map, :end)

    map.cells
    |> Enum.filter(fn {_, cell} -> cell.height == 0 end)
    |> Task.async_stream(
      fn {_, cell} ->
        map = explore_map(map, cell, 0, @distance_to_beat)
        map.cells |> Map.get(end_cell.position) |> Map.get(:distance)
      end,
      timeout: :infinity
    )
    |> Stream.map(&elem(&1, 1))
    |> Stream.reject(&is_nil/1)
    |> Enum.min()
  end
end
