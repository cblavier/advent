defmodule Advent.Y2020.Day20.Part1 do
  import Enum, only: [join: 1]
  import String, only: [replace: 3, reverse: 1, slice: 3, split: 2, to_integer: 1]

  def run(puzzle) do
    puzzle
    |> parse_puzzle()
    |> tiles_by_matching_borders_count()
    |> find_corners()
    |> Enum.reduce(1, fn %{id: id}, acc -> id * acc end)
  end

  def parse_puzzle(puzzle) do
    for tile <- split(puzzle, "\n\n") do
      [id | rows] = split(tile, "\n")
      id = id |> slice(5, 4) |> to_integer()

      borders = for s <- ~w(top right bottom left)a, do: rows |> find_border(s) |> border_hash()

      {id, %{id: id, borders: borders, rows: rows}}
    end
    |> Map.new()
  end

  def border_hash(border) do
    binary = border |> replace("#", "1") |> replace(".", "0")
    {Integer.parse(binary, 2) |> elem(0), binary |> reverse() |> Integer.parse(2) |> elem(0)}
  end

  def find_border(rows, :top), do: Enum.at(rows, 0)
  def find_border(rows, :right), do: rows |> Enum.map(&slice(&1, 9, 1)) |> join()
  def find_border(rows, :bottom), do: rows |> Enum.at(-1)
  def find_border(rows, :left), do: rows |> Enum.map(&slice(&1, 0, 1)) |> join()

  def find_corners(tiles_by_matching_borders_count) do
    Map.get(tiles_by_matching_borders_count, 2)
  end

  def tiles_by_matching_borders_count(tiles) do
    tiles
    |> Enum.map(fn {_, tile} -> {tile, matching_borders_count(tile, tiles)} end)
    |> Enum.group_by(fn {_, count} -> count end, fn {tile, _} -> tile end)
  end

  def matching_borders_count(%{id: tile_id, borders: tile_borders}, tiles) do
    tiles
    |> Map.values()
    |> Enum.reject(fn %{id: id} -> tile_id == id end)
    |> Enum.count(fn %{borders: t_borders} ->
      for(b1 <- tile_borders, b2 <- t_borders, do: {b1, b2})
      |> Enum.any?(fn {{b11, b12}, {b21, _b22}} -> b11 == b21 || b12 == b21 end)
    end)
  end
end
