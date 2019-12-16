defmodule Advent.Y2015.Day02.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.reduce(0, fn present, acc ->
      [l, w, h] =
        present
        |> String.split("x")
        |> Enum.map(&String.to_integer/1)

      acc + (2 * l * w + 2 * w * h + 2 * h * l) + Enum.min([l * w, w * h, h * l])
    end)
  end
end
