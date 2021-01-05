defmodule Advent.Y2015.Day15.Part2 do
  alias Advent.Y2015.Day15.Part1

  def run(puzzle) do
    ingredients = Part1.parse(puzzle)

    [capacities, durabilities, flavors, textures, calories] =
      for i <- 0..4, do: Part1.property_scores(ingredients, i)

    for repartition <- Part1.repartitions(100) do
      capacity = Part1.compute_property(repartition, capacities)
      durability = Part1.compute_property(repartition, durabilities)
      flavor = Part1.compute_property(repartition, flavors)
      texture = Part1.compute_property(repartition, textures)
      calory = Part1.compute_property(repartition, calories)
      {calory, capacity * durability * flavor * texture}
    end
    |> Enum.filter(&(elem(&1, 0) == 500))
    |> Enum.map(&elem(&1, 1))
    |> Enum.max()
  end
end
