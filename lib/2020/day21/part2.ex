defmodule Advent.Y2020.Day21.Part2 do
  alias Advent.Y2020.Day21.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&Part1.parse_line/1)
    |> Part1.group_by_allergens()
    |> Part1.find_allergen_food_candidates()
    |> Part1.match_allergens()
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.map(&elem(&1, 0))
    |> Enum.join(",")
  end
end
