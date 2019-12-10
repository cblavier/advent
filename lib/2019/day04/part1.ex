defmodule Advent.Y2019.Day04.Part1 do
  @digit_count 6

  def run(min, max) do
    codes =
      for code <- produce_codes(),
          in_range?(code, min, max),
          has_two_consecutive_digits?(code) do
        code
      end

    length(codes)
  end

  def produce_codes(range \\ 0..9, depth \\ 0, max_depth \\ @digit_count)

  def produce_codes(range, depth, max_depth) when depth + 1 < max_depth do
    Enum.flat_map(range, fn i ->
      0..i
      |> produce_codes(depth + 1, max_depth)
      |> Enum.map(&(i + &1 * 10))
    end)
  end

  def produce_codes(range, _depth, _max_depth), do: range

  def in_range?(code, min, max), do: code >= min && code <= max

  @doc ~S"""
  iex> alias Advent.Y2019.Day04.Part1
  iex> Part1.has_two_consecutive_digits?(123456)
  false
  iex> Part1.has_two_consecutive_digits?(122456)
  true
  iex> Part1.has_two_consecutive_digits?(111111)
  true
  """
  def has_two_consecutive_digits?(code) do
    code
    |> Integer.digits()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.any?(fn [c1, c2] -> c1 == c2 end)
  end
end
