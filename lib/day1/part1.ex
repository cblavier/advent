defmodule Advent2019.Day1.Part1 do
  def run(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&fuel/1)
    |> Enum.sum()
  end

  @doc ~S"""
  ## Examples
    iex> Advent2019.Day1.Part1.fuel(10)
    1
    iex> Advent2019.Day1.Part1.fuel(1969)
    654
  """
  def fuel(weight), do: div(weight, 3) - 2
end
