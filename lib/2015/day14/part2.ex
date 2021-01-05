defmodule Advent.Y2015.Day14.Part2 do
  alias Advent.Y2015.Day14.Part1

  def run(puzzle) do
    reindeers = Part1.parse(puzzle)

    for duration <- 1..2503 do
      distances = Enum.map(reindeers, &Part1.run(&1, duration))
      max_distance = Enum.max(distances)

      Enum.map(distances, fn
        ^max_distance -> 1
        _ -> 0
      end)
    end
    |> Enum.zip()
    |> Enum.map(&(&1 |> Tuple.to_list() |> Enum.sum()))
    |> Enum.max()
  end
end
