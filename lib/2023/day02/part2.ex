defmodule Advent.Y2023.Day02.Part2 do
  import Advent.Y2023.Day02.Part1

  def run(puzzle) do
    puzzle
    |> parse()
    |> Enum.map(fn {_index, sets} -> power(sets) end)
    |> Enum.sum()
  end

  defp power(sets) do
    for set <- sets, reduce: %{red: 0, green: 0, blue: 0} do
      acc ->
        for {item, count} <- set, reduce: acc do
          acc ->
            if Map.get(acc, item) <= count do
              Map.put(acc, item, count)
            else
              acc
            end
        end
    end
    |> Map.values()
    |> Enum.product()
  end
end
