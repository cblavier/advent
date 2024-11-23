defmodule Advent.Y2020.Day10.Part2 do
  def run(puzzle) do
    {:ok, memo} = Agent.start(fn -> %{} end)

    puzzle
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> memoized_find_arrangements(0, memo)
  end

  def memoized_find_arrangements(joltages, current, memo) do
    case Agent.get(memo, &Map.get(&1, {joltages, current})) do
      nil ->
        result = find_arrangements(joltages, current, memo)
        Agent.update(memo, &Map.put(&1, {joltages, current}, result))
        result

      result ->
        result
    end
  end

  def find_arrangements([], _current, _memo), do: 1

  def find_arrangements(joltages, current, memo) do
    joltages
    |> Enum.slice(0..2)
    |> Enum.with_index()
    |> Enum.filter(fn {joltage, _index} -> joltage - current <= 3 end)
    |> Enum.map(fn {joltage, index} ->
      {joltage, Enum.slice(joltages, (index + 1)..-1//1)}
    end)
    |> Enum.map(fn {joltage, tail} ->
      memoized_find_arrangements(tail, joltage, memo)
    end)
    |> Enum.sum()
  end
end
