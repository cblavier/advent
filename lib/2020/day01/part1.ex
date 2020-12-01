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
  def find_sum_to([i | tail], sum) do
    case find_sum_to(i, tail, sum) do
      nil -> find_sum_to(tail, sum)
      {i, j} -> {i, j}
    end
  end

  defp find_sum_to(i, list, sum) do
    Enum.reduce_while(list, nil, fn j, _ ->
      if i + j == sum do
        {:halt, {i, j}}
      else
        {:cont, nil}
      end
    end)
  end
end
