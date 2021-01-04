defmodule Advent.Y2015.Day09.Part1 do
  def run(puzzle) do
    {paths, cities} = parse_puzzle(puzzle)

    cities
    |> permutations()
    |> Enum.map(&distance(&1, paths))
    |> Enum.min()
  end

  def parse_puzzle(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.reduce({%{}, []}, fn line, {paths, cities} ->
      [path, distance] = String.split(line, " = ")
      [from, to] = String.split(path, " to ")
      distance = String.to_integer(distance)
      paths = paths |> Map.put({from, to}, distance) |> Map.put({to, from}, distance)
      cities = Enum.uniq([from, to | cities])
      {paths, cities}
    end)
  end

  def permutations([]), do: [[]]

  def permutations(list) do
    for elem <- list, rest <- permutations(list -- [elem]) do
      [elem | rest]
    end
  end

  def distance(cities, paths, distance \\ 0)
  def distance([_city], _paths, distance), do: distance

  def distance([from, to | tail], paths, distance) do
    distance = distance + Map.get(paths, {from, to}, 1_000_000)
    distance([to | tail], paths, distance)
  end
end
