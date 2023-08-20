defmodule Advent.Y2022.Day02.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn round ->
      [p1, p2] = String.split(round, " ")
      match(p1, p2)
    end)
    |> Enum.sum()
  end

  defp match(p1, p2) do
    outcome = outcome(p2)
    score(outcome) + (p1 |> figure(outcome) |> score())
  end

  defp figure("A", :lost), do: "Z"
  defp figure("A", :draw), do: "X"
  defp figure("A", :won), do: "Y"

  defp figure("B", :lost), do: "X"
  defp figure("B", :draw), do: "Y"
  defp figure("B", :won), do: "Z"

  defp figure("C", :lost), do: "Y"
  defp figure("C", :draw), do: "Z"
  defp figure("C", :won), do: "X"

  defp score("X"), do: 1
  defp score("Y"), do: 2
  defp score("Z"), do: 3

  defp score(:lost), do: 0
  defp score(:draw), do: 3
  defp score(:won), do: 6

  defp outcome("X"), do: :lost
  defp outcome("Y"), do: :draw
  defp outcome("Z"), do: :won
end
