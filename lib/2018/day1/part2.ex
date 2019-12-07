defmodule Advent.Y2018.Day1.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> find_first_redundant()
  end

  @doc ~S"""
  iex> import Advent.Y2018.Day1.Part2
  iex> find_first_redundant([1, -1])
  0
  iex> find_first_redundant([3, 3, 4, -2, -4])
  10
  # iex> find_first_redundant([-6, 3, 8, 5, -6])
  # 5
  # iex> find_first_redundant([7, 7, -2, -7, -4])
  # 5
  """
  def find_first_redundant(frequencies) do
    frequencies
    |> Stream.cycle()
    |> Enum.reduce_while({MapSet.new([0]), 0}, fn freq, {acc, last} ->
      new_freq = last + freq

      if MapSet.member?(acc, new_freq) do
        {:halt, new_freq}
      else
        {:cont, {MapSet.put(acc, new_freq), new_freq}}
      end
    end)
  end
end
