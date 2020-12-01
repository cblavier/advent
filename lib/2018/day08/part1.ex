defmodule Advent.Y2018.Day08.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> process_license()
  end

  @doc ~S"""
  iex> import Advent.Y2018.Day08.Part1
  iex> process_license([2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2])
  138
  """
  def process_license([]), do: {0, 0}

  def process_license(license) do
    IO.inspect(license)
    [child_count, metadata_count | tail] = license
    child_data = Enum.slice(tail, 0..(-1 - metadata_count))

    if child_count > 0 do
      {offset, metadata_sum} =
        Enum.reduce(1..child_count, {0, 0}, fn _i, {offset, metadata_acc} ->
          {new_offset, metadata_sum} = child_data |> Enum.slice(offset..-1) |> process_license()
          {new_offset, metadata_sum + metadata_acc}
        end)

      {offset + 2, metadata_sum}
    else
      metadata_sum = tail |> Enum.slice(-metadata_count..-1) |> Enum.sum()
      IO.inspect(metadata_sum, label: "metadata_sum")
      {metadata_count + 2, metadata_sum}
    end
    |> IO.inspect()
  end
end
