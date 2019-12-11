defmodule Advent.Y2018.Day02.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split()
    |> checksum()
  end

  @doc ~S"""
  iex> alias Advent.Y2018.Day02.Part1
  iex> box_ids = ~w(abcdef bababc abbcde abcccd aabcdd abcdee ababab)
  iex> Part1.checksum(box_ids)
  12
  """
  def checksum(box_ids) do
    {doubles, triples} =
      box_ids
      |> Enum.map(&has_double_and_triple?/1)
      |> Enum.reduce({0, 0}, fn {has_double, has_triple}, {doubles, triples} ->
        {doubles, triples} = if has_double, do: {doubles + 1, triples}, else: {doubles, triples}
        if has_triple, do: {doubles, triples + 1}, else: {doubles, triples}
      end)

    doubles * triples
  end

  @doc ~S"""
  iex> alias Advent.Y2018.Day02.Part1
  iex> Part1.has_double_and_triple?("abcdef")
  {false, false}
  iex> Part1.has_double_and_triple?("bababc")
  {true, true}
  iex> Part1.has_double_and_triple?("abbcde")
  {true, false}
  iex> Part1.has_double_and_triple?("abcccd")
  {false, true}
  iex> Part1.has_double_and_triple?("aabcdd")
  {true, false}
  iex> Part1.has_double_and_triple?("abcdee")
  {true, false}
  iex> Part1.has_double_and_triple?("ababab")
  {false, true}
  """
  def has_double_and_triple?(box_id) do
    occurences =
      box_id
      |> String.graphemes()
      |> Enum.reduce(%{}, fn char, acc ->
        Map.update(acc, char, 1, &(&1 + 1))
      end)
      |> Map.values()

    {
      Enum.member?(occurences, 2),
      Enum.member?(occurences, 3)
    }
  end
end
