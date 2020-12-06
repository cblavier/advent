defmodule Advent.Y2020.Day06.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split("\n\n")
    |> Enum.map(&process_group/1)
    |> Enum.sum()
  end

  def process_group(group) do
    group
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> Enum.reduce(nil, fn
      list, nil -> MapSet.new(list)
      list, acc -> list |> MapSet.new() |> MapSet.intersection(acc)
    end)
    |> Enum.count()
  end
end
