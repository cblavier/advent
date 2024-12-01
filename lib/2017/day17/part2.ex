defmodule Advent.Y2017.Day17.Part2 do
  def run(puzzle) do
    step = String.to_integer(puzzle)
    rounds = 50_000_000

    1..rounds
    |> Enum.reduce({0, 0}, fn i, {value_after_0, pos} ->
      pos = rem(pos + step, i)
      value_after_0 = if pos == 0, do: i, else: value_after_0
      {value_after_0, rem(pos + 1, i + 1)}
    end)
    |> elem(0)
  end
end
