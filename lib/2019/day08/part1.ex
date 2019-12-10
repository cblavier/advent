defmodule Advent.Y2019.Day08.Part1 do
  @image_size 25 * 6

  def run(puzzle) do
    layer =
      puzzle
      |> String.graphemes()
      |> Enum.chunk_every(@image_size)
      |> Enum.map(&color_map/1)
      |> Enum.min_by(& &1[0])

    layer[1] * layer[2]
  end

  defp color_map(layer) do
    Enum.reduce(layer, %{}, fn color, acc ->
      Map.update(acc, String.to_integer(color), 1, &(&1 + 1))
    end)
  end
end
