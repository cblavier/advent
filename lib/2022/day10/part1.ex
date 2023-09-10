defmodule Advent.Y2022.Day10.Part1 do
  def run(puzzle) do
    values = register_values(puzzle)

    for i <- [20, 60, 100, 140, 180, 220], reduce: 0 do
      acc -> acc + Enum.at(values, i - 1) * i
    end
  end

  def register_values(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.flat_map(fn
      "noop" -> [:noop]
      "addx " <> count -> [:noop, {:addx, String.to_integer(count)}]
    end)
    |> Enum.reduce([1], fn
      :noop, acc = [head | _tail] -> [head | acc]
      {:addx, count}, acc = [head | _tail] -> [head + count | acc]
    end)
    |> Enum.reverse()
    |> Enum.slice(0, 240)
  end
end
