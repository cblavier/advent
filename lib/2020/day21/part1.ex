defmodule Advent.Y2020.Day21.Part1 do
  def run(puzzle) do
    food_lines = puzzle |> String.split("\n") |> Enum.map(&parse_line/1)

    allergen_matching =
      food_lines
      |> group_by_allergens()
      |> find_allergen_food_candidates()
      |> match_allergens()

    count_unmatched_foods(food_lines, allergen_matching)
  end

  def parse_line(line) do
    [foods, allergens] = line |> String.slice(0..-2//1) |> String.split(" (contains ")
    foods = foods |> String.split(" ") |> Enum.map(&String.trim/1)
    allergens = allergens |> String.split(",") |> Enum.map(&String.trim/1)
    {foods, allergens}
  end

  def group_by_allergens(lines) do
    Enum.reduce(lines, %{}, fn {foods, allergens}, acc ->
      Enum.reduce(allergens, acc, fn allergen, acc ->
        Map.update(acc, allergen, [MapSet.new(foods)], &[MapSet.new(foods) | &1])
      end)
    end)
  end

  def find_allergen_food_candidates(allergens_with_foods) do
    for {allergen, food_lists} <- allergens_with_foods,
        into: %{},
        do: {allergen, intersection(food_lists)}
  end

  def match_allergens(allergens_with_foods, matched \\ %{})

  def match_allergens(allergens_with_foods, matched) when map_size(allergens_with_foods) == 0,
    do: matched

  def match_allergens(allergens_with_foods, matched) do
    matching = Enum.filter(allergens_with_foods, fn {_, foods} -> length(foods) == 1 end)
    matching_foods = Enum.flat_map(matching, &elem(&1, 1))

    {allergens_with_foods, matched} =
      Enum.reduce(matching, {allergens_with_foods, matched}, fn {allergen, [food]},
                                                                {allergens_with_foods, matched} ->
        allergens_with_foods =
          Enum.reduce(allergens_with_foods, %{}, fn {allergen, foods}, acc ->
            case Enum.reject(foods, &(&1 in matching_foods)) do
              [] -> acc
              foods -> Map.put(acc, allergen, foods)
            end
          end)

        matched = Map.put(matched, food, allergen)
        {allergens_with_foods, matched}
      end)

    match_allergens(allergens_with_foods, matched)
  end

  def count_unmatched_foods(lines, allergen_matching) do
    Enum.reduce(lines, 0, fn {foods, _}, acc ->
      acc + Enum.count(foods, &(Map.get(allergen_matching, &1) == nil))
    end)
  end

  def intersection([set]), do: Enum.to_list(set)
  def intersection([s1, s2 | tail]), do: intersection([MapSet.intersection(s1, s2) | tail])
end
