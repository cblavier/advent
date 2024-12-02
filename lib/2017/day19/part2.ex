defmodule Advent.Y2017.Day19.Part2 do
  alias Advent.Y2017.Day19.Part1

  def run(puzzle) do
    puzzle |> Part1.parse() |> Part1.explore() |> elem(1)
  end
end
