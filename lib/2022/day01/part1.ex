defmodule Advent.Y2022.Day01.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n\n")
    |> Enum.map(fn chunk ->
      chunk
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
    |> Enum.max()
  end
end
