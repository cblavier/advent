defmodule Advent.Y2020.Day24.Part2 do
  alias Advent.Y2020.Day24.Part1

  def run(puzzle) do
    puzzle
    |> Part1.parse()
    |> Enum.reduce(%{}, &Part1.follow_path/2)
    |> evolve(100)
    |> Part1.count(:black)
  end

  def evolve(tiles, 0), do: tiles

  def evolve(tiles, generations) do
    (tiles_flips(tiles, :black, [0, 3, 4, 5, 6]) ++ tiles_flips(tiles, :white, [2]))
    |> Enum.reduce(tiles, fn pos, tiles -> Part1.flip_tile(tiles, pos) end)
    |> evolve(generations - 1)
  end

  def tiles_flips(tiles, color, counts) do
    tiles
    |> Stream.filter(fn {_, c} -> c == color end)
    |> Stream.map(fn {pos, _} ->
      {pos, tiles |> neighbor_colors(pos) |> Enum.count(&(&1 == :black))}
    end)
    |> Stream.filter(fn {_, count} -> count in counts end)
    |> Enum.map(&elem(&1, 0))
  end

  @shifts [{2, 0}, {-2, 0}, {1, -1}, {-1, -1}, {1, 1}, {-1, 1}]
  def neighbor_colors(tiles, {x, y}) do
    for {shift_x, shift_y} <- @shifts do
      Map.get(tiles, {x + shift_x, y + shift_y}, :white)
    end
  end
end
