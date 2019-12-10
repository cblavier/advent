defmodule Advent.Y2018.Day01.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> apply_frequencies()
  end

  @doc ~S"""
  iex> import Advent.Y2018.Day01.Part1
  iex> apply_frequencies([1, 1, 1])
  3
  iex> apply_frequencies([1, 1, -2])
  0
  iex> apply_frequencies([-1, -2, -3])
  -6
  """
  def apply_frequencies(frequencies) do
    Enum.sum(frequencies)
  end
end
