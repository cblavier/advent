defmodule Advent.Y2019.Day4.Part2 do
  alias Advent.Y2019.Day4.Part1

  def run(min, max) do
    codes =
      for code <- Part1.produce_codes(),
          Part1.in_range?(code, min, max),
          has_exactly_two_consecutive_digits?(code) do
        code
      end

    length(codes)
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
    |> Integer.digits()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(%{}, fn [c1, c2], acc ->
      if c1 == c2, do: Map.update(acc, c1, 1, &(&1 + 1)), else: acc
    end)
    |> Map.values()
    |> Enum.member?(1)
  end
end
