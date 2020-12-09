defmodule Advent.Y2020.Day09.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Stream.map(&String.to_integer/1)
    |> find_invalid_set()
    |> Enum.at(-1)
  end

  def find_invalid_set(puzzle) do
    puzzle
    |> Stream.chunk_every(26, 1, :discard)
    |> Stream.reject(&is_valid_chunk?/1)
    |> Enum.at(0)
  end

  def is_valid_chunk?(chunk) do
    [head | tail] = Enum.reverse(chunk)
    combinations = for i <- tail, j <- tail, i != j, do: i + j
    Enum.member?(combinations, head)
  end
end
