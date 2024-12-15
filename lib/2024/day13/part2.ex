defmodule Advent.Y2024.Day13.Part2 do
  alias Advent.Y2024.Day13.Part1

  def run(puzzle) do
    puzzle
    |> Part1.parse(10_000_000_000_000)
    |> Enum.map(&Part1.solve/1)
    |> Enum.map(& &1.prize)
    |> Enum.sum()
  end
end
