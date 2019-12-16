defmodule Advent.Y2015.Day03.Part2 do
  def run(puzzle) do
    puzzle
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce({{0, 0}, {0, 0}, MapSet.new([{0, 0}])}, fn
      {">", i}, {{x1, y1}, {x2, y2}, acc} ->
        if rem(i, 2) == 0 do
          {{x1 + 1, y1}, {x2, y2}, MapSet.put(acc, {x1 + 1, y1})}
        else
          {{x1, y1}, {x2 + 1, y2}, MapSet.put(acc, {x2 + 1, y2})}
        end

      {"<", i}, {{x1, y1}, {x2, y2}, acc} ->
        if rem(i, 2) == 0 do
          {{x1 - 1, y1}, {x2, y2}, MapSet.put(acc, {x1 - 1, y1})}
        else
          {{x1, y1}, {x2 - 1, y2}, MapSet.put(acc, {x2 - 1, y2})}
        end

      {"v", i}, {{x1, y1}, {x2, y2}, acc} ->
        if rem(i, 2) == 0 do
          {{x1, y1 - 1}, {x2, y2}, MapSet.put(acc, {x1, y1 - 1})}
        else
          {{x1, y1}, {x2, y2 - 1}, MapSet.put(acc, {x2, y2 - 1})}
        end

      {"^", i}, {{x1, y1}, {x2, y2}, acc} ->
        if rem(i, 2) == 0 do
          {{x1, y1 + 1}, {x2, y2}, MapSet.put(acc, {x1, y1 + 1})}
        else
          {{x1, y1}, {x2, y2 + 1}, MapSet.put(acc, {x2, y2 + 1})}
        end
    end)
    |> elem(2)
    |> Enum.count()
  end
end
