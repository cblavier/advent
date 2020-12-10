defmodule Advent.Y2015.Day05.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.filter(&is_nice?/1)
    |> Enum.count()
  end

  def is_nice?(s) do
    s_array = String.graphemes(s)
    has_repeating_pairs?(s_array) and has_repeating_letters?(s_array)
  end

  def has_repeating_pairs?(s_array) do
    chunks = s_array |> Enum.with_index() |> Enum.chunk_every(2, 1, :discard)

    tests =
      for [{a1, i1}, {a2, i2}] <- chunks,
          [{b1, j1}, {b2, j2}] <- chunks,
          a1 == b1 && a2 == b2,
          i1 != j1 && i1 != j2 && i2 != j1 && i2 != j2 do
        true
      end

    Enum.any?(tests)
  end

  def has_repeating_letters?(s_array) do
    s_array
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.any?(fn [a, _, b] -> a == b end)
  end
end
