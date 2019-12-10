defmodule Advent.Y2019.Day01.Part2 do
  alias Advent.Y2019.Day01.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&total_weight([&1]))
    |> Enum.sum()
  end

  @doc ~S"""
  iex> Advent.Y2019.Day01.Part2.total_weight([1969])
  966
  iex> Advent.Y2019.Day01.Part2.total_weight([100_756])
  50_346
  """
  def total_weight(weights) do
    added_weight = weights |> hd |> Part1.fuel()

    if added_weight > 0 do
      total_weight([added_weight] ++ weights)
    else
      weights |> List.delete_at(-1) |> Enum.sum()
    end
  end
end
