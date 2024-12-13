defmodule Advent.Y2024.Day09.Part1 do
  def run(puzzle) do
    blocks = parse_blocks(puzzle)
    free_blocks = free_blocks(blocks)
    last_blocks = last_blocks(blocks, length(free_blocks))
    blocks |> defrag(free_blocks, last_blocks) |> checksum()
  end

  def defrag(blocks, [first | _], [last | _]) when first >= last, do: blocks

  def defrag(blocks, [first | free_blocks], [last | last_blocks]) do
    {v, blocks} = Map.pop!(blocks, last)
    blocks |> Map.put(first, v) |> defrag(free_blocks, last_blocks)
  end

  def parse_blocks(puzzle) do
    puzzle
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.with_index()
    |> Enum.flat_map(fn
      {[block_id, free_count], i} -> List.duplicate(i, block_id) ++ List.duplicate(nil, free_count)
      {[block_id], i} -> List.duplicate(i, block_id)
    end)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {block, index}, acc ->
      Map.put(acc, index, block)
    end)
  end

  def free_blocks(blocks) do
    blocks
    |> Enum.filter(fn {_, v} -> is_nil(v) end)
    |> Enum.sort_by(fn {i, _v} -> i end)
    |> Enum.map(fn {i, _} -> i end)
  end

  def last_blocks(blocks, n) do
    blocks
    |> Enum.filter(fn {_, v} -> not is_nil(v) end)
    |> Enum.sort_by(fn {i, _v} -> i end, :desc)
    |> Enum.map(fn {i, _} -> i end)
    |> Enum.take(n)
  end

  def checksum(blocks) do
    for {i, v} <- blocks, v != nil, reduce: 0 do
      acc -> acc + i * v
    end
  end
end
