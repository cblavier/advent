defmodule Advent.Y2020.Day24.Part1 do
  def run(puzzle) do
    puzzle
    |> parse()
    |> Enum.reduce(%{}, &follow_path/2)
    |> count(:black)
  end

  def parse(puzzle) do
    for line <- String.split(puzzle, "\n") do
      line
      |> String.graphemes()
      |> Enum.chunk_while(
        "",
        fn
          c, acc when c in ~w(e w) -> {:cont, acc <> c, ""}
          c, acc when c in ~w(s n) -> {:cont, acc <> c}
        end,
        fn acc -> {:cont, acc} end
      )
    end
  end

  def follow_path(path, tiles) do
    position =
      Enum.reduce(path, {0, 0}, fn
        "e", {x, y} -> {x + 2, y}
        "w", {x, y} -> {x - 2, y}
        "se", {x, y} -> {x + 1, y - 1}
        "sw", {x, y} -> {x - 1, y - 1}
        "ne", {x, y} -> {x + 1, y + 1}
        "nw", {x, y} -> {x - 1, y + 1}
      end)

    flip_tile(tiles, position)
  end

  def flip_tile(tiles, position) do
    tiles
    |> Map.update(position, :black, fn
      :black -> :white
      :white -> :black
    end)
    |> init_neighbors(position)
  end

  @shifts [{2, 0}, {-2, 0}, {1, -1}, {-1, -1}, {1, 1}, {-1, 1}]
  def init_neighbors(tiles, {x, y}) do
    Enum.reduce(@shifts, tiles, fn {shift_x, shift_y}, tiles ->
      Map.update(tiles, {x + shift_x, y + shift_y}, :white, fn c -> c end)
    end)
  end

  def count(tiles, color) do
    tiles |> Map.values() |> Enum.count(&(&1 == color))
  end
end
