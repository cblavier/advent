defmodule Advent.Y2024.Day12.Part1 do
  defmodule Region do
    defstruct [:plant, :area, :perimeter, :sides, plots: MapSet.new()]
  end

  def run(puzzle) do
    puzzle
    |> parse()
    |> find_regions()
    |> Enum.map(&compute_area_and_perimeter/1)
    |> Enum.map(&(&1.area * &1.perimeter))
    |> Enum.sum()
  end

  def parse(puzzle) do
    for {row, y} <- puzzle |> String.split("\n") |> Enum.with_index(),
        {plant, x} <- row |> String.graphemes() |> Enum.with_index(),
        into: %{},
        do: {{x, y}, plant}
  end

  def find_regions(farm) do
    Enum.reduce(farm, {[], MapSet.new()}, fn {{x, y}, plant}, {regions, visited} ->
      if MapSet.member?(visited, {x, y}) do
        {regions, visited}
      else
        region = explore(farm, {x, y}, %Region{plant: plant})
        {[region | regions], MapSet.union(visited, MapSet.new(region.plots))}
      end
    end)
    |> elem(0)
  end

  def explore(farm, {x, y}, region = %Region{plant: plant, plots: plots}) do
    region = %Region{region | plots: MapSet.put(plots, {x, y})}

    for {nx, ny} <- [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}], reduce: region do
      region ->
        if Map.get(farm, {nx, ny}) == plant and not MapSet.member?(plots, {nx, ny}) do
          explore(farm, {nx, ny}, region)
        else
          region
        end
    end
  end

  defp compute_area_and_perimeter(region = %Region{plots: plots}) do
    fences =
      for {x, y} <- plots,
          {nx, ny} <- [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}],
          not MapSet.member?(plots, {nx, ny}),
          do: true

    %Region{region | area: MapSet.size(plots), perimeter: length(fences)}
  end
end
