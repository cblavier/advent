defmodule Advent.Y2017.Day02.Part1 do
  def run(puzzle) do
    for line <- String.split(puzzle, "\n"), reduce: 0 do
      sum ->
        items = for n <- String.split(line, "\t"), n = String.to_integer(n), do: n
        sum + Enum.max(items) - Enum.min(items)
    end
  end
end
