defmodule Advent.Y2024.Day06.Part2 do
  alias Advent.Y2024.Day06.Part1

  @grid_size 129

  def run(puzzle) do
    {map, pos_and_dir} = parse(puzzle)

    map
    |> empty_cells()
    |> Task.async_stream(&(map |> Map.put(&1, :wall) |> explore(pos_and_dir)))
    |> Enum.count(&(&1 == {:ok, :loop}))
  end

  defp parse(puzzle) do
    for {row, y} <- puzzle |> String.split("\n") |> Enum.with_index(), reduce: {%{}, nil} do
      {map, p_and_d} ->
        for {cell, x} <- row |> String.graphemes() |> Enum.with_index(), reduce: {map, p_and_d} do
          {map, p_and_d} ->
            case cell do
              "#" -> {Map.put(map, {x, y}, :wall), p_and_d}
              ">" -> {Map.put(map, {x, y}, {:visited, [:right]}), {x, y, :right}}
              "v" -> {Map.put(map, {x, y}, {:visited, [:down]}), {x, y, :down}}
              "<" -> {Map.put(map, {x, y}, {:visited, [:left]}), {x, y, :left}}
              "^" -> {Map.put(map, {x, y}, {:visited, [:up]}), {x, y, :up}}
              _ -> {map, p_and_d}
            end
        end
    end
  end

  defp empty_cells(map) do
    for x <- 0..@grid_size, y <- 0..@grid_size, Map.get(map, {x, y}) == nil, do: {x, y}
  end

  defp explore(_map, {x, y, _dir}) when x not in 0..@grid_size or y not in 0..@grid_size, do: :exit

  defp explore(map, {x, y, dir}) do
    map = mark(map, {x, y, dir})
    {new_x, new_y} = Part1.step(x, y, dir)

    case Map.get(map, {new_x, new_y}) do
      nil ->
        explore(map, {new_x, new_y, dir})

      {:visited, directions} ->
        if Enum.member?(directions, dir) do
          :loop
        else
          explore(map, {new_x, new_y, dir})
        end

      :wall ->
        explore(map, {x, y, Part1.turn(dir)})
    end
  end

  defp mark(map, {x, y, dir}) do
    case Map.get(map, {x, y}) do
      {:visited, directions} -> Map.put(map, {x, y}, {:visited, [dir | directions]})
      _ -> Map.put(map, {x, y}, {:visited, [dir]})
    end
  end
end
