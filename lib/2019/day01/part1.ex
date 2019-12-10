defmodule Advent.Y2019.Day01.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&fuel/1)
    |> Enum.sum()
  end

  @doc ~S"""
  iex> Advent.Y2019.Day01.Part1.fuel(10)
  1
  iex> Advent.Y2019.Day01.Part1.fuel(1969)
  654
  """
  def fuel(weight), do: div(weight, 3) - 2
end
