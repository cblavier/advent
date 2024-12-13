defmodule Advent.Y2024.Day09.Part2 do
  def run(puzzle) do
    blocks = parse(puzzle)

    filled_blocks =
      blocks
      |> Enum.reject(fn {_, {v, _}} -> is_nil(v) end)
      |> Enum.sort_by(fn {i, {_, _}} -> i end, :desc)

    blocks |> defrag(filled_blocks) |> checksum()
  end

  def defrag(blocks, []), do: blocks

  def defrag(blocks, [{i2, {v2, s2}} | filled_blocks]) do
    case first_free_fitting(blocks, s2, i2) do
      nil ->
        defrag(blocks, filled_blocks)

      {i1, {nil, s1}} ->
        blocks = blocks |> Map.put(i1, {v2, s2}) |> Map.delete(i2)
        blocks = if s1 == s2, do: blocks, else: Map.put(blocks, i1 + s2, {nil, s1 - s2})
        defrag(blocks, filled_blocks)
    end
  end

  defp first_free_fitting(blocks, size, index) do
    case Enum.filter(blocks, fn {i, {v, s}} -> is_nil(v) and s >= size and index > i end) do
      [] -> nil
      blocks -> Enum.min(blocks, fn {i1, _}, {i2, _} -> i1 <= i2 end)
    end
  end

  defp checksum(blocks) do
    Enum.reduce(blocks, 0, fn
      {_i, {nil, _size}}, acc -> acc
      {i, {v, size}}, acc -> acc + Enum.sum(i..(i + size - 1)//1) * v
    end)
  end

  defp parse(puzzle) do
    puzzle
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.with_index()
    |> Enum.reduce({%{}, 0}, fn
      {[occupied, free], i}, {acc, index} ->
        acc = acc |> Map.put(index, {i, occupied}) |> Map.put(index + occupied, {nil, free})
        {acc, index + free + occupied}

      {[occupied], i}, {acc, index} ->
        Map.put(acc, index, {i, occupied})
    end)
  end
end
