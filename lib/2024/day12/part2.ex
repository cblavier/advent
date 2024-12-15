defmodule Advent.Y2024.Day12.Part2 do
  alias Advent.Y2024.Day12.Part1
  alias Advent.Y2024.Day12.Part1.Region

  import MapSet, only: [member?: 2]

  def run(puzzle) do
    puzzle
    |> Part1.parse()
    |> Part1.find_regions()
    |> Enum.map(&compute_area_and_sides/1)
    |> Enum.map(&(&1.area * &1.sides))
    |> Enum.sum()
  end

  defp compute_area_and_sides(region = %Region{plots: plots}) do
    corners =
      for {x, y} <- plots,
          [{d1x, d1y}, {d2x, d2y}, {d3x, d3y}] <- [
            [{-1, 0}, {-1, -1}, {0, -1}],
            [{0, -1}, {1, -1}, {1, 0}],
            [{1, 0}, {1, 1}, {0, 1}],
            [{0, 1}, {-1, 1}, {-1, 0}]
          ],
          [n1, n2, n3] = [{x + d1x, y + d1y}, {x + d2x, y + d2y}, {x + d3x, y + d3y}],
          (not member?(plots, n1) and not member?(plots, n3)) or
            (member?(plots, n1) and not member?(plots, n2) and member?(plots, n3)),
          do: true

    %Region{region | area: MapSet.size(plots), sides: length(corners)}
  end
end
