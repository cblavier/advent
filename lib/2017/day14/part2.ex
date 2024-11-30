defmodule Advent.Y2017.Day14.Part2 do
  alias Advent.Y2017.Day10.Part2, as: KnotHash

  def run(puzzle) do
    grid = build_grid(puzzle)

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while(grid, fn
      i, grid when grid == %{} ->
        {:halt, i}

      _i, grid ->
        square = grid |> Map.keys() |> Enum.at(0)
        {:cont, visit(grid, square)}
    end)
  end

  defp build_grid(puzzle) do
    Task.async_stream(0..127, fn i ->
      hash = KnotHash.run("#{puzzle}-#{i}", :binary)
      {i, String.graphemes(hash)}
    end)
    |> Enum.reduce(%{}, fn {:ok, {y, hash}}, acc ->
      hash
      |> Enum.with_index()
      |> Enum.reduce(acc, fn
        {"0", _}, acc -> acc
        {"1", x}, acc -> Map.put(acc, {x, y}, true)
      end)
    end)
  end

  defp visit(grid, square = {x, y}) do
    grid = Map.delete(grid, square)

    for {nx, ny} <- [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}], reduce: grid do
      grid ->
        if Map.get(grid, {nx, ny}) do
          visit(grid, {nx, ny})
        else
          grid
        end
    end
  end
end
