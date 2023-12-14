defmodule Advent.Y2023.Day01.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn line ->
      chars = line |> String.to_charlist() |> Enum.filter(&Enum.member?(?0..?9, &1))
      chars = [Enum.at(chars, 0), Enum.at(chars, -1)]
      chars |> to_string() |> String.to_integer()
    end)
    |> Enum.sum()
  end
end
