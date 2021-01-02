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
    (black_tiles_flips(tiles) ++ white_tiles_flips(tiles))
    |> Enum.reduce(tiles, fn pos, tiles -> Part1.flip_tile(tiles, pos) end)
    |> evolve(generations - 1)
  end

  def black_tiles_flips(tiles) do
    tiles
    |> Stream.filter(fn {_, color} -> color == :black end)
    |> Stream.map(fn {pos, _} ->
      {pos, tiles |> neighbor_colors(pos) |> Enum.count(&(&1 == :black))}
    end)
    |> Stream.filter(fn {_, count} -> count == 0 || count > 2 end)
    |> Enum.map(&elem(&1, 0))
  end

  def white_tiles_flips(tiles) do
    tiles
    |> Stream.filter(fn {_, color} -> color == :white end)
    |> Stream.map(fn {pos, _} ->
      {pos, tiles |> neighbor_colors(pos) |> Enum.count(&(&1 == :black))}
    end)
    |> Stream.filter(fn {_, count} -> count == 2 end)
    |> Enum.map(&elem(&1, 0))
  end

  @shifts [{2, 0}, {-2, 0}, {1, -1}, {-1, -1}, {1, 1}, {-1, 1}]
  def neighbor_colors(tiles, {x, y}) do
    for {shift_x, shift_y} <- @shifts do
      Map.get(tiles, {x + shift_x, y + shift_y}, :white)
    end
  end
end
