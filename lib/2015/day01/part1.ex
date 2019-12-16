defmodule Advent.Y2015.Day01.Part1 do
  def run(puzzle) do
    puzzle
    |> String.graphemes()
    |> Enum.reduce(0, fn
      "(", acc -> acc + 1
      ")", acc -> acc - 1
    end)
  end
end
