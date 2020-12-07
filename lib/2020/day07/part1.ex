defmodule Advent.Y2020.Day07.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&parse_rule/1)
    |> Map.new()
    |> paths_to("shiny gold")
  end

  @doc ~S"""
  iex> import Advent.Y2020.Day07.Part1
  iex> parse_rule("plaid brown bags contain 3 bright lime bags, 5 plaid coral bags.")
  {"plaid brown", [{3, "bright lime"}, {5, "plaid coral"}]}
  iex> parse_rule("plaid brown bags contain 1 bright lime bag, 1 plaid coral bag.")
  {"plaid brown", [{1, "bright lime"}, {1, "plaid coral"}]}
  iex> parse_rule("plaid brown bags contain no other bags.")
  {"plaid brown", []}
  """
  def parse_rule(rule) do
    [key, tail] = String.split(rule, " bags contain ")

    values =
      tail
      |> String.split([", ", ".", " bags", "bag"])
      |> Enum.reject(&(&1 == "" || &1 == "no other"))
      |> Enum.map(fn count_and_color ->
        [count, color] = String.split(count_and_color, " ", parts: 2)
        {String.to_integer(count), String.trim(color)}
      end)

    {key, values}
  end

  def paths_to(rulebook, target_color) do
    rulebook
    |> Enum.reject(fn {color, _} -> color == target_color end)
    |> Enum.map(fn {color, _} -> has_path_to?(rulebook, color, target_color) end)
    |> Enum.count(& &1)
  end

  def has_path_to?(_rulebook, color, color), do: true

  def has_path_to?(rulebook, color, target_color) do
    case Map.get(rulebook, color) do
      nil -> false
      list -> Enum.any?(list, &has_path_to?(rulebook, elem(&1, 1), target_color))
    end
  end
end
