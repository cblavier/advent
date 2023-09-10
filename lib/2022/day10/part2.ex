defmodule Advent.Y2022.Day10.Part2 do
  import Advent.Y2022.Day10.Part1

  def run(puzzle) do
    puzzle
    |> register_values()
    |> Enum.with_index()
    |> Enum.map(fn {v, i} ->
      if Enum.member?((rem(i, 40) - 1)..(rem(i, 40) + 1), v) do
        "#"
      else
        "."
      end
    end)
    |> Enum.chunk_every(40)
    |> Enum.map(&Enum.join/1)
  end
end
