defmodule Advent.Y2022.Day03.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split()
    |> Enum.chunk_every(3)
    |> Enum.map(fn [comp1, comp2, comp3] ->
      comp1 = comp1 |> String.graphemes() |> MapSet.new()
      comp2 = comp2 |> String.graphemes() |> MapSet.new()

      [common] =
        comp3
        |> String.graphemes()
        |> Enum.find(&(MapSet.member?(comp1, &1) && MapSet.member?(comp2, &1)))
        |> String.to_charlist()

      priority(common)
    end)
    |> Enum.sum()
  end

  defp priority(c) when c in ?a..?z, do: c - ?a + 1
  defp priority(c) when c in ?A..?Z, do: c - ?A + 27
end
