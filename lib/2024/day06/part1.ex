defmodule Advent.Y2024.Day06.Part1 do
  def run(puzzle) do
    puzzle |> parse() |> explore()
  end

  defp parse(puzzle) do
    for {row, y} <- puzzle |> String.split("\n") |> Enum.with_index(), reduce: {%{}, nil} do
      {map, p_and_d} ->
        for {cell, x} <- row |> String.graphemes() |> Enum.with_index(), reduce: {map, p_and_d} do
          {map, p_and_d} ->
            case cell do
              "." -> {Map.put(map, {x, y}, :empty), p_and_d}
              "#" -> {Map.put(map, {x, y}, :wall), p_and_d}
              ">" -> {Map.put(map, {x, y}, {:visited, [:right]}), {x, y, :right}}
              "v" -> {Map.put(map, {x, y}, {:visited, [:down]}), {x, y, :down}}
              "<" -> {Map.put(map, {x, y}, {:visited, [:left]}), {x, y, :left}}
              "^" -> {Map.put(map, {x, y}, {:visited, [:up]}), {x, y, :up}}
            end
        end
    end
  end

  defp explore({map, {x, y, dir}}, count \\ 1) do
    map = Map.put(map, {x, y}, :visited)
    {new_x, new_y} = step(x, y, dir)

    case Map.get(map, {new_x, new_y}) do
      :empty -> explore({map, {new_x, new_y, dir}}, count + 1)
      :visited -> explore({map, {new_x, new_y, dir}}, count)
      :wall -> explore({map, {x, y, turn(dir)}}, count)
      nil -> count
    end
  end

  def step(x, y, :up), do: {x, y - 1}
  def step(x, y, :down), do: {x, y + 1}
  def step(x, y, :left), do: {x - 1, y}
  def step(x, y, :right), do: {x + 1, y}

  def turn(:up), do: :right
  def turn(:right), do: :down
  def turn(:down), do: :left
  def turn(:left), do: :up
end
