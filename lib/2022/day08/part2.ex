defmodule Advent.Y2022.Day08.Part2 do
  import Advent.Y2022.Day08.Part1

  @max_xy 98
  # @max_xy 4
  def run(puzzle) do
    grid = build_grid(puzzle)

    for(x <- 0..@max_xy, y <- 0..@max_xy, do: scenic_score(grid, x, y))
    |> Enum.max()
  end

  defp scenic_score(grid, x, y) do
    [:top, :bottom, :left, :right]
    |> Enum.map(&viewing_distance(&1, grid, x, y))
    |> Enum.product()
  end

  defp viewing_distance(:top, _grid, _x, 0), do: 0

  defp viewing_distance(:top, grid, x, y) do
    tree = at(grid, x, y)

    Enum.reduce_while((y - 1)..0, 0, fn y, acc ->
      reducer(tree, grid, x, y, acc)
    end)
  end

  defp viewing_distance(:bottom, _grid, _x, @max_xy), do: 0

  defp viewing_distance(:bottom, grid, x, y) do
    tree = at(grid, x, y)

    Enum.reduce_while((y + 1)..@max_xy, 0, fn y, acc ->
      reducer(tree, grid, x, y, acc)
    end)
  end

  defp viewing_distance(:left, _grid, 0, _y), do: 0

  defp viewing_distance(:left, grid, x, y) do
    tree = at(grid, x, y)

    Enum.reduce_while((x - 1)..0, 0, fn x, acc ->
      reducer(tree, grid, x, y, acc)
    end)
  end

  defp viewing_distance(:right, _grid, @max_xy, _y), do: 0

  defp viewing_distance(:right, grid, x, y) do
    tree = at(grid, x, y)

    Enum.reduce_while((x + 1)..@max_xy, 0, fn x, acc ->
      reducer(tree, grid, x, y, acc)
    end)
  end

  defp reducer(tree, grid, x, y, acc) do
    if at(grid, x, y) < tree do
      {:cont, acc + 1}
    else
      {:halt, acc + 1}
    end
  end
end
