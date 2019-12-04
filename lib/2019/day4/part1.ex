defmodule Advent.Y2019.Day4.Part1 do
  @digit_count 6

  def run(min, max) do
    produce_codes()
    |> Stream.filter(&in_range?(&1, min, max))
    |> Stream.filter(&has_two_consecutive_digits?/1)
    |> Enum.count()
  end

  def produce_codes(range \\ 0..9, depth \\ 0, max_depth \\ @digit_count) do
    Enum.flat_map(range, fn i ->
      if depth + 1 < max_depth do
        0..i
        |> produce_codes(depth + 1, max_depth)
        |> Enum.map(&(i + &1 * 10))
      else
        [i]
      end
    end)
  end

  def in_range?(code, min, max) do
    code >= min && code <= max
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day4.Part1
  iex> Part1.has_two_consecutive_digits?(123456)
  false
  iex> Part1.has_two_consecutive_digits?(122456)
  true
  iex> Part1.has_two_consecutive_digits?(111111)
  true
  """
  def has_two_consecutive_digits?(code) do
    code
    |> to_string()
    |> String.graphemes()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.any?(fn [c1, c2] -> c1 == c2 end)
  end
end
