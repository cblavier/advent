defmodule Advent.Y2017.Day01.Part1 do
  def run(puzzle) do
    puzzle
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> circular_chunk()
    |> Enum.filter(fn [a, b] -> a == b end)
    |> Enum.map(fn [a, _b] -> a end)
    |> Enum.sum()
  end

  defp circular_chunk(list) do
    first = hd(list)
    Enum.chunk_every(list, 2, 1, [first])
  end
end
