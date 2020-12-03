defmodule Advent.Y2020.Day03.Part1 do
  @x_motion 3
  @y_motion 1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> build_slope()
    |> ski_down(@x_motion, @y_motion)
  end

  def build_slope(puzzle) do
    Enum.map(puzzle, &(&1 |> String.graphemes() |> Stream.cycle()))
  end

  def ski_down(slope, x_motion, y_motion) do
    Stream.cycle([0])
    |> Enum.reduce_while({0, 0, 0}, fn _, {x, y, trees} ->
      {new_x, new_y} = {x + x_motion, y + y_motion}
      trees = if slope |> Enum.at(y) |> Enum.at(x) == "#", do: trees + 1, else: trees
      if new_y >= length(slope), do: {:halt, trees}, else: {:cont, {new_x, new_y, trees}}
    end)
  end
end
