defmodule Advent.Y2024.Day01.Part1 do
  import String, only: [to_integer: 1]

  def run(puzzle) do
    puzzle
    |> parse()
    |> then(fn {l1, l2} -> Enum.zip(Enum.sort(l1), Enum.sort(l2)) end)
    |> Enum.reduce(0, fn {n1, n2}, acc -> acc + abs(n1 - n2) end)
  end

  def parse(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.reduce({[], []}, fn line, {acc1, acc2} ->
      [n1, n2] = String.split(line, "   ")
      {[to_integer(n1) | acc1], [to_integer(n2) | acc2]}
    end)
  end
end
