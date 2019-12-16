defmodule Advent.Y2015.Day03.Part1 do
  def run(puzzle) do
    puzzle
    |> String.graphemes()
    |> Enum.reduce({{0, 0}, MapSet.new([{0, 0}])}, fn
      ">", {{x, y}, acc} -> {{x + 1, y}, MapSet.put(acc, {x + 1, y})}
      "<", {{x, y}, acc} -> {{x - 1, y}, MapSet.put(acc, {x - 1, y})}
      "^", {{x, y}, acc} -> {{x, y - 1}, MapSet.put(acc, {x, y - 1})}
      "v", {{x, y}, acc} -> {{x, y + 1}, MapSet.put(acc, {x, y + 1})}
    end)
    |> elem(1)
    |> Enum.count()
  end
end
