defmodule Advent.Y2015.Day01.Part2 do
  def run(puzzle) do
    puzzle
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce_while(0, fn
      {"(", _index}, acc -> {:cont, acc + 1}
      {")", index}, acc when acc == 0 -> {:halt, index + 1}
      {")", _index}, acc -> {:cont, acc - 1}
    end)
  end
end
