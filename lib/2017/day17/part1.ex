defmodule Advent.Y2017.Day17.Part1 do
  def run(puzzle) do
    #
    step = String.to_integer(puzzle)
    rounds = 2017

    1..rounds
    |> Enum.reduce({%{0 => 0}, 0}, fn i, {acc, pos} ->
      pos = rem(pos + step, i)

      acc =
        Enum.reduce(i..(pos + 1)//-1, acc, fn pos, acc ->
          Map.put(acc, pos, Map.get(acc, pos - 1))
        end)
        |> Map.put(pos + 1, i)

      {acc, rem(pos + 1, i + 1)}
    end)
    |> then(fn {acc, pos} ->
      Map.get(acc, rem(pos + 1, rounds))
    end)
  end
end
