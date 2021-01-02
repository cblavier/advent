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
      Enum.reduce(path, {0, 0}, fn dir, {x, y} ->
        {move_x, move_y} = moves() |> Map.get(dir)
        {x + move_x, y + move_y}
      end)

    flip_tile(tiles, position)
  end

  def moves do
    %{
      "e" => {2, 0},
      "w" => {-2, 0},
      "se" => {1, -1},
      "sw" => {-1, -1},
      "ne" => {1, 1},
      "nw" => {-1, 1}
    }
  end

  def flip_tile(tiles, position) do
    tiles
    |> Map.update(position, :black, fn
      :black -> :white
      :white -> :black
    end)
    |> init_neighbors(position)
  end

  def init_neighbors(tiles, {x, y}) do
    moves()
    |> Map.values()
    |> Enum.reduce(tiles, fn {shift_x, shift_y}, tiles ->
      Map.put_new(tiles, {x + shift_x, y + shift_y}, :white)
    end)
  end

  def count(tiles, color) do
    tiles |> Map.values() |> Enum.count(&(&1 == color))
  end
end
