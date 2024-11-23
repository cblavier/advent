defmodule Advent.Y2017.Day02.Part2 do
  def run(puzzle) do
    for line <- String.split(puzzle, "\n"), reduce: 0 do
      sum ->
        items = line |> String.split("\t") |> Enum.map(&String.to_integer/1)
        [div] = for a <- items, b <- items, a != b, Integer.mod(a, b) == 0, do: div(a, b)
        sum + div
    end
  end
end
