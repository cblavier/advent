defmodule Advent.Y2015.Day09.Part2 do
  alias Advent.Y2015.Day09.Part1

  def run(puzzle) do
    {paths, cities} = Part1.parse_puzzle(puzzle)

    cities
    |> Part1.permutations()
    |> Enum.map(&Part1.distance(&1, paths))
    |> Enum.max()
  end
end
