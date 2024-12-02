defmodule Advent.Y2024.Day02.Part2 do
  alias Advent.Y2024.Day02.Part1

  def run(puzzle) do
    puzzle |> Part1.parse() |> Enum.count(&almost_safe?/1)
  end

  def almost_safe?(report) do
    Enum.any?(
      0..(length(report) - 1),
      &(report |> List.delete_at(&1) |> Part1.safe?())
    )
  end
end
