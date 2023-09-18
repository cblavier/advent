defmodule Advent.Y2022.Day12.Part2 do
  import Advent.Y2022.Day12.Part1

  alias Advent.Y2022.Day12.Part1.{AreaMap, Cell}

  def run(puzzle) do
    map = puzzle |> parse_map() |> reverse_map()
    start_cell = find_cell(map, :start)

    map
    |> explore_map(start_cell)
    |> Map.get(:cells)
    |> Enum.filter(fn {_, cell} -> cell.kind == :end && cell.distance end)
    |> Enum.map(fn {_, cell} -> cell.distance end)
    |> Enum.min()
  end

  defp reverse_map(map = %AreaMap{cells: cells}) do
    cells =
      for {pos, cell} <- cells, into: %{} do
        case cell do
          %Cell{kind: :start, height: h} -> {pos, %Cell{cell | kind: :end, height: ?z - h}}
          %Cell{kind: :end, height: h} -> {pos, %Cell{cell | kind: :start, height: ?z - h}}
          %Cell{height: 0} -> {pos, %Cell{cell | kind: :end, height: ?z}}
          %Cell{height: h} -> {pos, %Cell{cell | height: ?z - h}}
        end
      end

    %AreaMap{map | cells: cells}
  end
end
