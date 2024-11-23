defmodule Advent.Y2017.Day01.Part2 do
  def run(puzzle) do
    puzzle = puzzle |> String.graphemes() |> Enum.map(&String.to_integer/1)
    length = length(puzzle)

    for {a, i} <- Enum.with_index(puzzle), reduce: 0 do
      sum ->
        ahead = Enum.at(puzzle, rem(i + div(length, 2), length))
        if a == ahead, do: sum + a, else: sum
    end
  end
end
