defmodule Advent.Y2017.Day11.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split(",")
    |> Enum.reduce({0, 0, 0}, &move/2)
    |> distance()
  end

  def move(direction, {q, r, s}) do
    case direction do
      "n" -> {q, r - 1, s + 1}
      "s" -> {q, r + 1, s - 1}
      "ne" -> {q + 1, r - 1, s}
      "sw" -> {q - 1, r + 1, s}
      "nw" -> {q - 1, r, s + 1}
      "se" -> {q + 1, r, s - 1}
    end
  end

  def distance({q, r, s}) do
    div(abs(q) + abs(r) + abs(s), 2)
  end
end
