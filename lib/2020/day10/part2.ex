defmodule Advent.Y2020.Day10.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> find_arrangements()
  end

  def find_arrangements(joltages, current \\ 0, acc \\ 0)
  def find_arrangements([], _current, acc), do: acc + 1

  def find_arrangements(joltages, current, acc) do
    joltages
    |> Enum.slice(0..2)
    |> Enum.with_index()
    |> Enum.filter(fn {joltage, _index} -> joltage - current <= 3 end)
    |> Enum.map(fn {joltage, index} ->
      {joltage, Enum.slice(joltages, (index + 1)..-1)}
    end)
    |> Enum.reduce(acc, fn {joltage, tail}, acc ->
      find_arrangements(tail, joltage, acc)
    end)
  end
end
