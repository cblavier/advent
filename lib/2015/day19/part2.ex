defmodule Advent.Y2015.Day19.Part2 do
  alias Advent.Y2015.Day19.Part1

  @attemps 10_000

  def run(puzzle) do
    {rules, molecule} = Part1.parse(puzzle)

    rules
    |> Stream.iterate(&Enum.shuffle/1)
    |> Task.async_stream(fn rules ->
      molecule
      |> reduce(rules)
    end)
    |> Stream.map(&elem(&1, 1))
    |> Stream.reject(&is_nil/1)
    |> Stream.take(@attemps)
    |> Enum.min()
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
    Enum.find(rules, fn [_, replacement] -> Regex.match?(~r/#{replacement}/, molecule) end)
  end

  def apply_match(molecule, [pattern, replacement]) do
    String.replace(molecule, replacement, pattern)
  end
end
