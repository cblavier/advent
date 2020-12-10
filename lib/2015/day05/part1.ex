defmodule Advent.Y2015.Day05.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.filter(&is_nice?/1)
    |> Enum.count()
  end

  def is_nice?(s) do
    s_array = String.graphemes(s)

    has_3_vowels?(s_array) and
      has_twice_letters?(s_array) and
      has_not_forbbiden_sequences?(s_array)
  end

  def has_3_vowels?(s_array) do
    count = s_array |> Enum.filter(&(&1 in ~w(a e i o u))) |> length()
    count >= 3
  end

  def has_twice_letters?(s_array) do
    s_array
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.any?(fn [a, b] -> a == b end)
  end

  def has_not_forbbiden_sequences?(s_array) do
    s_array
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn
      ["a", "b"] -> false
      ["c", "d"] -> false
      ["p", "q"] -> false
      ["x", "y"] -> false
      _ -> true
    end)
  end
end
