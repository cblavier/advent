defmodule Advent.Y2015.Day13.Part2 do
  alias Advent.Y2015.Day13.Part1

  def run(puzzle) do
    {happiness_changes, guests} = Part1.parse(puzzle)

    guests
    |> MapSet.put(:me)
    |> Part1.guest_pair_combinations()
    |> Enum.map(&Part1.apply_happiness(&1, happiness_changes))
    |> Enum.max()
  end
end
