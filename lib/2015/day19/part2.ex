defmodule Advent.Y2015.Day19.Part2 do
  alias Advent.Y2015.Day19.Part1

  def run(puzzle) do
    {rules, molecule} = Part1.parse(puzzle)

    rules
    |> Stream.iterate(&Enum.shuffle/1)
    |> Stream.map(&reduce(molecule, &1))
    |> Stream.reject(&is_nil/1)
    |> Enum.at(0)
  end

  def reduce(molecule, rules, count \\ 0)
  def reduce("e", _rules, count), do: count

  def reduce(molecule, rules, count) do
    case find_match(molecule, rules) do
      nil -> nil
      rule -> molecule |> apply_match(rule) |> reduce(rules, count + 1)
    end
  end

  def find_match(molecule, rules) do
    Enum.find(rules, fn [_, repl] -> String.contains?(molecule, repl) end)
  end

  def apply_match(molecule, [pattern, repl]) do
    String.replace(molecule, repl, pattern, global: false)
  end
end
