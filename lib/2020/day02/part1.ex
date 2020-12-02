defmodule Advent.Y2020.Day02.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&parse_password_and_policy/1)
    |> Enum.count(&valid_password?/1)
  end

  @doc ~S"""
  iex> import Advent.Y2020.Day02.Part1
  iex> parse_password_and_policy("1-3 a: abcde")
  {"abcde", {"a", 1, 3}}
  """
  @pwd_regex Regex.compile!(~S/(?<min>\d+)-(?<max>\d+) (?<pattern>.): (?<password>.+)/)
  def parse_password_and_policy(password_and_policy) do
    %{"min" => min, "max" => max, "pattern" => pattern, "password" => password} =
      Regex.named_captures(@pwd_regex, password_and_policy)

    {password, {pattern, String.to_integer(min), String.to_integer(max)}}
  end

  @doc ~S"""
  iex> import Advent.Y2020.Day02.Part1
  iex> valid_password?({"abcde", {"a", 1, 3}})
  true
  iex> valid_password?({"cdefg", {"b", 1, 3}})
  false
  """
  def valid_password?({password, {pattern, min_occurence, max_occurence}}) do
    pattern_count = password |> String.graphemes() |> Enum.count(&(&1 == pattern))
    pattern_count >= min_occurence && pattern_count <= max_occurence
  end
end
