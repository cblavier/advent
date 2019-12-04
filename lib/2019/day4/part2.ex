defmodule Advent.Y2019.Day4.Part2 do
  alias Advent.Y2019.Day4.Part1

  def run(min, max) do
    Part1.produce_codes()
    |> Stream.filter(&Part1.in_range?(&1, min, max))
    |> Stream.filter(&has_exactly_two_consecutive_digits?/1)
    |> Enum.count()
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day4.Part2
  iex> Part2.has_exactly_two_consecutive_digits?(123456)
  false
  iex> Part2.has_exactly_two_consecutive_digits?(122456)
  true
  iex> Part2.has_exactly_two_consecutive_digits?(111111)
  false
  """
  def has_exactly_two_consecutive_digits?(code) do
    code
    |> to_string()
    |> String.graphemes()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(%{}, fn [c1, c2], acc ->
      if c1 == c2 do
        Map.update(acc, c1, 1, &(&1 + 1))
      else
        acc
      end
    end)
    |> Map.values()
    |> Enum.member?(1)
  end
end
