defmodule Advent.Y2022.Day12.Part1 do
  defmodule AreaMap do
    defstruct [:cells, :size]
  end

  defmodule Cell do
    defstruct [:height, :kind, :position, :distance, visited: false]
  end

  def run(puzzle) do
    map = parse_map(puzzle)
    {start_cell, end_cell} = {find_cell(map, :start), find_cell(map, :end)}
    map = explore_map(map, start_cell)
    map.cells |> Map.get(end_cell.position) |> Map.get(:distance)
  end

  def parse_map(puzzle) do
    cells =
      puzzle
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.map(fn {line, y} ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.map(fn
          {"S", x} -> %Cell{kind: :start, height: 0, position: {x, y}}
          {"E", x} -> %Cell{kind: :end, height: ?z - ?a, position: {x, y}}
          {s, x} -> %Cell{height: (s |> String.to_charlist() |> hd()) - ?a, position: {x, y}}
        end)
      end)

    size = length(cells)
    cells = for cell <- List.flatten(cells), into: %{}, do: {cell.position, cell}
    %AreaMap{cells: cells, size: size}
  end

  def find_cell(map, kind) do
    Enum.find_value(map.cells, fn
      {_pos, cell = %Cell{kind: ^kind}} -> cell
      _ -> false
    end)
  end

  def explore_map(map, cell, distance \\ 0)

  def explore_map(map, cell = %Cell{kind: :end}, distance) do
    %{map | cells: Map.update!(map.cells, cell.position, &%{&1 | distance: distance})}
  end

  def explore_map(map, cell, distance) do
    map = %{map | cells: Map.update!(map.cells, cell.position, &%{&1 | distance: distance})}

    map
    |> valid_neighbors(cell.position, distance)
    |> Enum.reduce(map, &explore_map(&2, &1, distance + 1))
  end

  defp valid_neighbors(map, position = {x, y}, distance) do
    current = Map.get(map.cells, position)

    for nx <- [x - 1, x, x + 1],
        ny <- [y - 1, y, y + 1],
        {nx, ny} != {x, y},
        nx == x or ny == y,
        reduce: [] do
      acc ->
        case Map.get(map.cells, {nx, ny}) do
          c = %Cell{height: h, distance: best_distance}
          when h <= current.height + 1 and (is_nil(best_distance) or best_distance > distance + 1) ->
            [c | acc]

          _ ->
            acc
        end
    end
  end
end
