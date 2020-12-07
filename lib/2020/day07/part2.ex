defmodule Advent.Y2020.Day07.Part2 do
  alias Advent.Y2020.Day07.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&Part1.parse_rule/1)
    |> Map.new()
    |> contained_bags_count("shiny gold")
  end

  def contained_bags_count(puzzle, color) do
    puzzle
    |> Map.get(color, [])
    |> Enum.map(fn {count, color} ->
      count + count * contained_bags_count(puzzle, color)
    end)
    |> Enum.sum()
  end
end
