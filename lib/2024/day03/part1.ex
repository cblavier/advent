defmodule Advent.Y2024.Day03.Part1 do
  def run(puzzle) do
    Regex.scan(~r|mul\(\d+,\d+\)|, puzzle)
    |> Enum.map(fn [s] -> evaluate_mul(s) end)
    |> Enum.sum()
  end

  def evaluate_mul(s) do
    [_, n1, n2, _] = String.split(s, ["(", ",", ")"])
    String.to_integer(n1) * String.to_integer(n2)
  end
end
