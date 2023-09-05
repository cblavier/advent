defmodule Advent.Y2022.Day08.Part1 do
  @max_xy 98
  def run(puzzle) do
    grid = build_grid(puzzle)

    for(x <- 0..@max_xy, y <- 0..@max_xy, do: visible?(grid, x, y))
    |> Enum.count(& &1)
  end

  def build_grid(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn row ->
      row |> String.graphemes() |> Enum.map(&String.to_integer/1)
    end)
  end

  defp visible?(_grid, 0, _y), do: true
  defp visible?(_grid, _x, 0), do: true
  defp visible?(_grid, _x, @max_xy), do: true
  defp visible?(_grid, @max_xy, _y), do: true

  defp visible?(grid, x, y) do
    Enum.any?([:top, :bottom, :left, :right], &visible_in_direction?(&1, grid, x, y))
  end

  defp visible_in_direction?(:top, grid, x, y) do
    tree = at(grid, x, y)
    Enum.all?(0..(y - 1), &(at(grid, x, &1) < tree))
  end

  defp visible_in_direction?(:left, grid, x, y) do
    tree = at(grid, x, y)
    Enum.all?(0..(x - 1), &(at(grid, &1, y) < tree))
  end

  defp visible_in_direction?(:bottom, grid, x, y) do
    tree = at(grid, x, y)
    Enum.all?((y + 1)..@max_xy, &(at(grid, x, &1) < tree))
  end

  defp visible_in_direction?(:right, grid, x, y) do
    tree = at(grid, x, y)
    Enum.all?((x + 1)..@max_xy, &(at(grid, &1, y) < tree))
  end

  def at(grid, x, y) do
    grid |> Enum.at(y) |> Enum.at(x)
  end
end
