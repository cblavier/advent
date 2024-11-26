defmodule Advent.Y2017.Day03.Part2 do
  alias Advent.Y2017.Day03.Part1

  def run(puzzle) do
    puzzle = String.to_integer(puzzle)

    Stream.iterate({:down, 0}, &Part1.next_move/1)
    |> Stream.flat_map(&Part1.flatten_moves/1)
    |> Enum.reduce_while({%{{0, 0} => 1}, {0, 0}}, fn move, {grid, pos} ->
      new_pos = Part1.move(pos, move)
      value = value(grid, new_pos)

      if value >= puzzle do
        {:halt, value}
      else
        {:cont, {Map.put(grid, new_pos, value), new_pos}}
      end
    end)
  end

  defp value(grid, {x, y}) do
    for new_x <- (x - 1)..(x + 1), new_y <- (y - 1)..(y + 1), reduce: 0 do
      sum -> sum + Map.get(grid, {new_x, new_y}, 0)
    end
  end
end
