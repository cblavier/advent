defmodule Advent.Y2020.Day06.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n\n")
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end
end
