defmodule Advent.Y2022.Day03.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split()
    |> Enum.map(fn rucksack ->
      size = String.length(rucksack)
      {compartment1, compartment2} = String.split_at(rucksack, div(size, 2))
      compartment1 = compartment1 |> String.graphemes() |> MapSet.new()

      [common] =
        compartment2
        |> String.graphemes()
        |> Enum.find(&MapSet.member?(compartment1, &1))
        |> String.to_charlist()

      priority(common)
    end)
    |> Enum.sum()
  end

  defp priority(c) when c in ?a..?z, do: c - ?a + 1
  defp priority(c) when c in ?A..?Z, do: c - ?A + 27
end
