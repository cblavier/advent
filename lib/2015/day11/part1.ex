defmodule Advent.Y2015.Day11.Part1 do
  def run(puzzle) do
    puzzle |> stream_valid_passwords() |> Enum.take(1) |> to_string()
  end

  def stream_valid_passwords(puzzle) do
    puzzle
    |> String.to_charlist()
    |> Stream.iterate(&next/1)
    |> Stream.drop(1)
    |> Stream.filter(&has_no_forbidden_letter?/1)
    |> Stream.filter(&has_3_in_a_row?/1)
    |> Stream.filter(&no_overlapping_pairs?/1)
  end

  def next(password), do: password |> Enum.reverse() |> do_next() |> Enum.reverse()
  def do_next([?z | tail]), do: [?a | do_next(tail)]
  def do_next([c | tail]), do: [c + 1 | tail]

  def has_3_in_a_row?(password) do
    password
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.any?(fn [a, b, c] -> a == b - 1 && b == c - 1 end)
  end

  def has_no_forbidden_letter?(password), do: Enum.all?(password, &(&1 not in [?i, ?l, ?o]))

  def no_overlapping_pairs?(password, count \\ 0)
  def no_overlapping_pairs?(_password, 2), do: true
  def no_overlapping_pairs?(password, _) when length(password) < 2, do: false
  def no_overlapping_pairs?([a, a | tail], count), do: no_overlapping_pairs?(tail, count + 1)
  def no_overlapping_pairs?([_ | tail], count), do: no_overlapping_pairs?(tail, count)
end
