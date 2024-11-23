defmodule Advent.Y2015.Day19.Part1 do
  def run(puzzle) do
    {rules, molecule} = parse(puzzle)

    rules
    |> Enum.flat_map(&variations(molecule, &1))
    |> Enum.uniq()
    |> Enum.count()
  end

  def parse(puzzle) do
    [rules, molecule] = String.split(puzzle, "\n\n")
    rules = for rule <- String.split(rules, "\n"), do: String.split(rule, " => ")
    {rules, molecule}
  end

  def variations(molecule, [rule_pattern, rule_replacement]) do
    indices = Regex.scan(~r/#{rule_pattern}/, molecule, return: :index)

    for [{match_start, match_length}] <- indices do
      head = String.slice(molecule, 0..(match_start - 1)//1)
      tail = String.slice(molecule, (match_start + match_length)..-1//1)
      head <> rule_replacement <> tail
    end
  end
end
