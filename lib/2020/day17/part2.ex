defmodule Advent.Y2020.Day17.Part2 do
  alias Advent.Y2020.Day17.Part1

  @dimensions 4
  @generations 6

  def run(puzzle) do
    puzzle
    |> Part1.parse_puzzle(@dimensions)
    |> Part1.evolve(@dimensions, @generations)
    |> Part1.count_cubes()
  end
end
