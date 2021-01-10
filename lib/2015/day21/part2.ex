defmodule Advent.Y2015.Day21.Part2 do
  alias Advent.Y2015.Day21.Part1

  def run(puzzle) do
    boss = Part1.parse(puzzle)
    player = %{id: :player, armor: 0, damage: 0, hit_points: 100}

    Part1.gear_combinations(:infinite_gold)
    |> Enum.sort_by(&elem(&1, 0), &>=/2)
    |> Stream.map(fn {cost, gear} -> {cost, Part1.stuff(player, gear)} end)
    |> Stream.map(fn {cost, player} -> {cost, Part1.fight(player, boss)} end)
    |> Stream.filter(fn {_cost, winner} -> winner.id == :boss end)
    |> Enum.at(0)
    |> elem(0)
  end
end
