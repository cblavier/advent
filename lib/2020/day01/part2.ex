defmodule Advent.Y2020.Day01.Part2 do
  def run(puzzle) do
    {i, j, k} =
      puzzle
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> find_sum_to(2020)

    i * j * k
  end

  @doc ~S"""
  iex> import Advent.Y2020.Day01.Part2
  iex> find_sum_to([259, 1721, 979, 366, 299, 675, 1456], 2020)
  {979, 366, 675}
  """
  def find_sum_to(list, sum) do
    [result | _] = for i <- list, j <- list, k <- list, i + j + k == sum, do: {i, j, k}
    result
  end
end
