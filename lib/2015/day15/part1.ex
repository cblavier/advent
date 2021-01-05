defmodule Advent.Y2015.Day15.Part1 do
  def run(puzzle) do
    ingredients = parse(puzzle)

    [capacities, durabilities, flavors, textures] =
      for i <- 0..3, do: property_scores(ingredients, i)

    for repartition <- repartitions(100) do
      capacity = compute_property(repartition, capacities)
      durability = compute_property(repartition, durabilities)
      flavor = compute_property(repartition, flavors)
      texture = compute_property(repartition, textures)
      capacity * durability * flavor * texture
    end
    |> Enum.max()
  end

  def parse(puzzle) do
    for line <- String.split(puzzle, "\n") do
      [_name, tail] = String.split(line, ":")
      ~r/-?\d+/ |> Regex.scan(tail) |> Enum.map(&(&1 |> hd() |> String.to_integer()))
    end
  end

  def repartitions(teaspoons) do
    for i1 <- 0..teaspoons,
        i2 <- 0..teaspoons,
        i3 <- 0..teaspoons,
        i4 <- 0..teaspoons,
        i1 + i2 + i3 + i4 == teaspoons,
        do: [i1, i2, i3, i4]
  end

  def property_scores(ingredients, property_index),
    do: for(i <- ingredients, do: Enum.at(i, property_index))

  def compute_property(repartition, property_scores),
    do:
      max(
        0,
        repartition
        |> Enum.zip(property_scores)
        |> Enum.map(fn {a, b} -> a * b end)
        |> Enum.sum()
      )
end
