defmodule Advent.Y2020.Day03.Part2 do
  alias Advent.Y2020.Day03.Part1

  @slopes [
    {1, 1},
    {3, 1},
    {5, 1},
    {7, 1},
    {1, 2}
  ]

  def run(puzzle) do
    @slopes
    |> Task.async_stream(fn {motion_x, motion_y} ->
      puzzle
      |> String.split("\n")
      |> Part1.build_slope()
      |> Part1.ski_down(motion_x, motion_y)
    end)
    |> Enum.reduce(1, fn {:ok, trees}, acc ->
      acc * trees
    end)
  end
end
