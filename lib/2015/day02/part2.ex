defmodule Advent.Y2015.Day02.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.reduce(0, fn present, acc ->
      [l, w, h] =
        present
        |> String.split("x")
        |> Enum.map(&String.to_integer/1)

      acc + l * w * h + Enum.min([2 * w + 2 * h, 2 * w + 2 * l, 2 * h + 2 * l])
    end)
  end
end
