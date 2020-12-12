defmodule Advent.Y2020.Day12.Part1 do
  def run(puzzle) do
    {x, y, _} =
      puzzle
      |> String.split("\n")
      |> Stream.map(&parse_instruction/1)
      |> Enum.reduce({0, 0, "E"}, &move_ferry/2)

    abs(x) + abs(y)
  end

  def parse_instruction(line) do
    {instruction, value} = String.split_at(line, 1)
    {instruction, String.to_integer(value)}
  end

  def move_ferry({"N", n}, {x, y, dir}), do: {x, y - n, dir}
  def move_ferry({"S", n}, {x, y, dir}), do: {x, y + n, dir}
  def move_ferry({"E", n}, {x, y, dir}), do: {x + n, y, dir}
  def move_ferry({"W", n}, {x, y, dir}), do: {x - n, y, dir}
  def move_ferry({"F", n}, {x, y, dir}), do: move_ferry({dir, n}, {x, y, dir})

  def move_ferry({"R", n}, {x, y, dir}) do
    new_dir = dir |> to_degree() |> Kernel.+(n) |> rem(360) |> to_direction()
    {x, y, new_dir}
  end

  def move_ferry({"L", n}, {x, y, dir}) do
    new_dir = dir |> to_degree() |> Kernel.-(n) |> rem(360) |> to_direction()
    {x, y, new_dir}
  end

  def to_degree("N"), do: 0
  def to_degree("E"), do: 90
  def to_degree("S"), do: 180
  def to_degree("W"), do: 270

  def to_direction(i) when i < 0, do: to_direction(i + 360)
  def to_direction(0), do: "N"
  def to_direction(90), do: "E"
  def to_direction(180), do: "S"
  def to_direction(270), do: "W"
end
