defmodule Advent.Y2022.Day02.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn round ->
      [p1, p2] = String.split(round, " ")
      match(p1, p2)
    end)
    |> Enum.sum()
  end

  defp match("A", s = "X"), do: score(s) + draw()
  defp match("A", s = "Y"), do: score(s) + won()
  defp match("A", s = "Z"), do: score(s) + lost()

  defp match("B", s = "X"), do: score(s) + lost()
  defp match("B", s = "Y"), do: score(s) + draw()
  defp match("B", s = "Z"), do: score(s) + won()

  defp match("C", s = "X"), do: score(s) + won()
  defp match("C", s = "Y"), do: score(s) + lost()
  defp match("C", s = "Z"), do: score(s) + draw()

  defp score("X"), do: 1
  defp score("Y"), do: 2
  defp score("Z"), do: 3

  defp lost(), do: 0
  defp draw(), do: 3
  defp won(), do: 6
end
