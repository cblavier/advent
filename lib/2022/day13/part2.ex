defmodule Advent.Y2022.Day13.Part2 do
  import Advent.Y2022.Day13.Part1

  def run(puzzle) do
    packets =
      puzzle
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&parse_packet/1)
      |> Enum.concat([[[2]], [[6]]])
      |> Enum.sort(&pair_ordered?/2)

    i1 = Enum.find_index(packets, &(&1 == [[2]]))
    i2 = Enum.find_index(packets, &(&1 == [[6]]))

    (i1 + 1) * (i2 + 1)
  end

  defp pair_ordered?(p1, p2), do: pair_ordered?({p1, p2})
end
