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
  def find_sum_to([i | tail], sum) do
    case find_sum_to(i, tail, sum) do
      nil -> find_sum_to(tail, sum)
      {i, j, k} -> {i, j, k}
    end
  end

  def find_sum_to(_i, [], _sum), do: nil

  def find_sum_to(i, [j | tail], sum) do
    case find_sum_to(i, j, tail, sum) do
      nil -> find_sum_to(i, tail, sum)
      {i, j, k} -> {i, j, k}
    end
  end

  defp find_sum_to(i, j, list, sum) do
    Enum.reduce_while(list, nil, fn k, _ ->
      if i + j + k == sum do
        {:halt, {i, j, k}}
      else
        {:cont, nil}
      end
    end)
  end
end
