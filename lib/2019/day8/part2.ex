defmodule Advent.Y2019.Day8.Part2 do
  @image_width 25
  @image_height 6
  @transparent "2"

  @doc ~S"""
  iex> alias Advent.Y2019.Day8.Part2
  iex> Part2.run("0222112222120000", 2, 2)
  ~w(0 1 1 0)
  """
  def run(puzzle, image_width \\ @image_width, image_height \\ @image_height) do
    puzzle
    |> String.graphemes()
    |> Enum.chunk_every(image_width * image_height)
    |> merge_layers(image_width * image_height)
  end

  def merge_layers(layers, image_size) do
    transparent_layer = List.duplicate(@transparent, image_size)

    layers
    |> Enum.reverse()
    |> Enum.reduce(transparent_layer, fn layer, image ->
      image
      |> Enum.zip(layer)
      |> Enum.map(fn
        {image_color, @transparent} -> image_color
        {_, layer_color} -> layer_color
      end)
    end)
  end

  def print_image(image, width) do
    image
    |> Enum.map(fn
      "0" -> " "
      color -> color
    end)
    |> Enum.chunk_every(width)
    |> Enum.join("\n")
    |> IO.puts()
  end
end
