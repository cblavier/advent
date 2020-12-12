defmodule Advent.Y2020.Day12.Part2 do
  alias Advent.Y2020.Day12.Part1

  def run(puzzle) do
    {x, y, _, _} =
      puzzle
      |> String.split("\n")
      |> Stream.map(&Part1.parse_instruction/1)
      |> Enum.reduce({0, 0, 10, -1}, &move_ferry/2)

    abs(x) + abs(y)
  end

  def move_ferry({"N", n}, {x, y, wx, wy}), do: {x, y, wx, wy - n}
  def move_ferry({"S", n}, {x, y, wx, wy}), do: {x, y, wx, wy + n}
  def move_ferry({"E", n}, {x, y, wx, wy}), do: {x, y, wx + n, wy}
  def move_ferry({"W", n}, {x, y, wx, wy}), do: {x, y, wx - n, wy}
  def move_ferry({"R", 90}, {x, y, wx, wy}), do: {x, y, -wy, wx}
  def move_ferry({"R", 180}, {x, y, wx, wy}), do: {x, y, -wx, -wy}
  def move_ferry({"R", 270}, {x, y, wx, wy}), do: {x, y, wy, -wx}
  def move_ferry({"L", n}, acc), do: move_ferry({"R", 360 - n}, acc)
  def move_ferry({"F", n}, {x, y, wx, wy}), do: {x + n * wx, y + n * wy, wx, wy}
end
