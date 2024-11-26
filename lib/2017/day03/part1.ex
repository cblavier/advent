defmodule Advent.Y2017.Day03.Part1 do
  def run(puzzle) do
    puzzle = String.to_integer(puzzle)

    Stream.iterate({:down, 0}, &next_move/1)
    |> Stream.flat_map(&flatten_moves/1)
    |> Enum.reduce_while({1, {0, 0}}, fn move, {index, {x, y}} ->
      if index == puzzle do
        {:halt, abs(x) + abs(y)}
      else
        new_pos = move({x, y}, move)
        {:cont, {index + 1, new_pos}}
      end
    end)
  end

  def next_move({:down, count}), do: {:right, count + 1}
  def next_move({:right, count}), do: {:up, count}
  def next_move({:up, count}), do: {:left, count + 1}
  def next_move({:left, count}), do: {:down, count}

  def flatten_moves({direction, n}), do: List.duplicate(direction, n)

  def move({x, y}, :down), do: {x, y - 1}
  def move({x, y}, :right), do: {x + 1, y}
  def move({x, y}, :up), do: {x, y + 1}
  def move({x, y}, :left), do: {x - 1, y}
end
