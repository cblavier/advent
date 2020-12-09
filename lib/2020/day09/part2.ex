defmodule Advent.Y2020.Day09.Part2 do
  alias Advent.Y2020.Day09.Part1

  def run(puzzle) do
    puzzle = puzzle |> String.split("\n") |> Enum.map(&String.to_integer/1)

    sequence =
      puzzle
      |> Part1.find_invalid_set()
      |> Enum.at(-1)
      |> find_sequence(puzzle)

    Enum.min(sequence) + Enum.max(sequence)
  end

  def find_sequence(target, puzzle) do
    2..length(puzzle)
    |> Stream.flat_map(fn combination_size ->
      Stream.chunk_every(puzzle, combination_size, 1, :discard)
    end)
    |> Stream.filter(&(Enum.sum(&1) == target))
    |> Enum.at(0)
  end
end
