defmodule Advent.Y2020.Day02.Part2 do
  alias Advent.Y2020.Day02.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&Part1.parse_password_and_policy/1)
    |> Enum.count(&valid_password?/1)
  end

  @doc ~S"""
  iex> import Advent.Y2020.Day02.Part2
  iex> valid_password?({"abcde", {"a", 1, 3}})
  true
  iex> valid_password?({"cdefg", {"b", 1, 3}})
  false
  """
  def valid_password?({password, {pattern, first_occurence, second_occurence}}) do
    chars = String.graphemes(password)

    {first_char, second_char} =
      {Enum.at(chars, first_occurence - 1), Enum.at(chars, second_occurence - 1)}

    (first_char == pattern && second_char != pattern) ||
      (first_char != pattern && second_char == pattern)
  end
end
