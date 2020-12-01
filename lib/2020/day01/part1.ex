defmodule Advent.Y2020.Day01.Part1 do
  def run(puzzle) do
    {i, j} =
      puzzle
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> find_sum_to(2020)

    i * j
  end

  @doc ~S"""
  iex> import Advent.Y2020.Day01.Part1
  iex> find_sum_to([259, 1721, 979, 366, 299, 675, 1456], 2020)
  {1721, 299}
  """
  def find_sum_to(list, sum) do
    [result | _] = for i <- list, j <- list, i + j == sum, do: {i, j}
    result
  end
end
