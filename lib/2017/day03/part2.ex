defmodule Advent.Y2017.Day03.Part2 do
  def run(puzzle) do
    puzzle = String.to_integer(puzzle)

    Stream.iterate({:down, 0}, &next_move/1)
    |> Stream.flat_map(&flatten_moves/1)
    |> Enum.reduce_while({%{{0, 0} => 1}, {0, 0}}, fn move, {grid, pos} ->
      new_pos = move(pos, move)
      value = value(grid, new_pos)

      if value >= puzzle do
        {:halt, value}
      else
        {:cont, {Map.put(grid, new_pos, value), new_pos}}
      end
    end)
  end

  defp next_move({:down, count}), do: {:right, count + 1}
  defp next_move({:right, count}), do: {:up, count}
  defp next_move({:up, count}), do: {:left, count + 1}
  defp next_move({:left, count}), do: {:down, count}

  defp flatten_moves({direction, n}), do: List.duplicate(direction, n)

  defp move({x, y}, :down), do: {x, y - 1}
  defp move({x, y}, :right), do: {x + 1, y}
  defp move({x, y}, :up), do: {x, y + 1}
  defp move({x, y}, :left), do: {x - 1, y}

  defp value(grid, {x, y}) do
    for new_x <- (x - 1)..(x + 1), new_y <- (y - 1)..(y + 1), reduce: 0 do
      sum -> sum + Map.get(grid, {new_x, new_y}, 0)
    end
  end
end
