defmodule Advent.Y2017.Day11.Part2 do
  alias Advent.Y2017.Day11.Part1

  def run(puzzle) do
    puzzle
    |> String.split(",")
    |> Enum.reduce({{0, 0, 0}, 0}, fn dir, {pos, max} ->
      pos = Part1.move(dir, pos)
      max = max(max, Part1.distance(pos))
      {pos, max}
    end)
    |> elem(1)
  end
end
