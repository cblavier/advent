defmodule Advent.Y2024.Day05.Part2 do
  alias Advent.Y2024.Day05.Part1

  def run(puzzle) do
    {rules, updates} = Part1.parse(puzzle)

    updates
    |> Enum.reject(&Part1.valid?(&1, rules))
    |> Enum.map(&for {p, i} <- Enum.with_index(&1), into: %{}, do: {i, p})
    |> Enum.map(&fix_update(&1, rules))
    |> Enum.map(&Map.get(&1, &1 |> Enum.count() |> div(2)))
    |> Enum.sum()
  end

  def fix_update(update, rules) do
    for i <- 1..(Enum.count(update) - 1), j <- 0..(i - 1), reduce: {nil, true} do
      {indexes, false} ->
        {indexes, false}

      {nil, true} ->
        {first, second} = {Map.get(update, j), Map.get(update, i)}

        if MapSet.member?(rules, {second, first}) do
          {{i, j}, false}
        else
          {nil, true}
        end
    end
    |> then(fn
      {nil, true} -> update
      {{i, j}, false} -> update |> swap(i, j) |> fix_update(rules)
    end)
  end

  defp swap(update, i, j) do
    update |> Map.put(i, Map.get(update, j)) |> Map.put(j, Map.get(update, i))
  end
end
