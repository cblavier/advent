defmodule Advent.Y2017.Day12.Part2 do
  alias Advent.Y2017.Day12.Part1

  def run(puzzle) do
    map = Part1.parse(puzzle)

    Stream.iterate(0, & &1)
    |> Enum.reduce_while({map, 0}, fn _, {map, n} ->
      program = map |> Map.keys() |> hd()
      visited = Part1.visit(map, program)

      case Map.drop(map, visited) do
        map when map == %{} -> {:halt, n + 1}
        map -> {:cont, {map, n + 1}}
      end
    end)
  end
end
