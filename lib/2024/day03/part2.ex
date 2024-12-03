defmodule Advent.Y2024.Day03.Part2 do
  import Advent.Y2024.Day03.Part1

  def run(puzzle) do
    Regex.scan(~r/(mul\(\d+,\d+\))|(do\(\))|(don't\(\))/, puzzle, capture: :all_but_first)
    |> Enum.flat_map(&Enum.reject(&1, fn match -> match == "" end))
    |> Enum.reduce(%{sum: 0, enabled: true}, fn
      "do()", acc -> %{acc | enabled: true}
      "don't()", acc -> %{acc | enabled: false}
      s, acc = %{enabled: true, sum: sum} -> %{acc | sum: sum + evaluate_mul(s)}
      _s, acc = %{enabled: false} -> acc
    end)
    |> Map.get(:sum)
  end
end
