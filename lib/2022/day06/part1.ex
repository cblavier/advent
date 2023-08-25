defmodule Advent.Y2022.Day06.Part1 do
  def run(puzzle) do
    run(puzzle, 4)
  end

  def run(puzzle, marker_size) do
    puzzle
    |> String.graphemes()
    |> Enum.chunk_every(marker_size, 1, :discard)
    |> Enum.with_index(marker_size)
    |> Enum.find(fn {chunk, _} -> chunk |> Enum.uniq() |> length == marker_size end)
    |> elem(1)
  end
end
