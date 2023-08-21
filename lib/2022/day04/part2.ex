defmodule Advent.Y2022.Day04.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split()
    |> Enum.count(fn pair ->
      [p11, p12, p21, p22] = pair |> String.split(["-", ","]) |> Enum.map(&String.to_integer/1)
      not Range.disjoint?(p11..p12, p21..p22)
    end)
  end
end
