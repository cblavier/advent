defmodule Advent.Y2015.Day21.Part1 do
  @weapon_shop [
    %{cost: 08, damage: 4, armor: 0},
    %{cost: 10, damage: 5, armor: 0},
    %{cost: 25, damage: 6, armor: 0},
    %{cost: 40, damage: 7, armor: 0},
    %{cost: 74, damage: 8, armor: 0}
  ]

  @armor_shop [
    %{cost: 00, damage: 0, armor: 0},
    %{cost: 13, damage: 0, armor: 1},
    %{cost: 31, damage: 0, armor: 2},
    %{cost: 53, damage: 0, armor: 3},
    %{cost: 75, damage: 0, armor: 4},
    %{cost: 102, damage: 0, armor: 5}
  ]

  @ring_shop [
    %{cost: 00, damage: 0, armor: 0},
    %{cost: 00, damage: 0, armor: 0},
    %{cost: 25, damage: 1, armor: 0},
    %{cost: 50, damage: 2, armor: 0},
    %{cost: 100, damage: 3, armor: 0},
    %{cost: 20, damage: 0, armor: 1},
    %{cost: 40, damage: 0, armor: 2},
    %{cost: 80, damage: 0, armor: 3}
  ]

  def run(puzzle) do
    boss = parse(puzzle)
    player = %{id: :player, armor: 0, damage: 0, hit_points: 100}

    gear_combinations(100)
    |> Enum.sort_by(&elem(&1, 0))
    |> Stream.map(fn {cost, gear} -> {cost, stuff(player, gear)} end)
    |> Stream.map(fn {cost, player} -> {cost, fight(player, boss)} end)
    |> Stream.filter(fn {_cost, winner} -> winner.id == :player end)
    |> Enum.at(0)
    |> elem(0)
  end

  def parse(puzzle) do
    for line <- String.split(puzzle, "\n"), into: %{id: :boss} do
      case String.split(line, ": ") do
        ["Armor", v] -> {:armor, String.to_integer(v)}
        ["Damage", v] -> {:damage, String.to_integer(v)}
        ["Hit Points", v] -> {:hit_points, String.to_integer(v)}
      end
    end
  end

  def fight(p1, p2) do
    case p1 |> damages(p2) |> deals(p2) do
      %{hit_points: 0} -> p1
      p2 -> fight(p2, p1)
    end
  end

  def gear_combinations(max_cost) do
    for weapon <- @weapon_shop,
        armor <- @armor_shop,
        {ring1, r1_index} <- Enum.with_index(@ring_shop),
        {ring2, r2_index} <- Enum.with_index(@ring_shop),
        r1_index != r2_index,
        total_cost = weapon.cost + armor.cost + ring1.cost + ring2.cost,
        total_cost <= max_cost || max_cost == :infinite_gold,
        do: {total_cost, [weapon, armor, ring1, ring2]}
  end

  def stuff(player, gear) do
    for %{damage: d, armor: a} <- gear, reduce: player do
      player = %{armor: player_armor, damage: player_damage} ->
        %{player | armor: player_armor + a, damage: player_damage + d}
    end
  end

  def damages(%{damage: d}, %{armor: a}), do: max(d - a, 1)
  def deals(damages, p = %{hit_points: h}), do: %{p | hit_points: max(0, h - damages)}
end
