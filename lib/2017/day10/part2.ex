defmodule Advent.Y2017.Day10.Part2 do
  alias Advent.Y2017.Day10.Part1

  @list_length 256

  def run(puzzle, output \\ :hex) do
    puzzle = parse(puzzle)

    Part1.build_list(@list_length)
    |> Part1.process(puzzle, 64)
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
    |> Enum.chunk_every(16)
    |> Enum.map(&checksum/1)
    |> process_output(output)
  end

  defp process_output(hash, :hex) do
    hash
    |> Enum.map_join(&(&1 |> Integer.to_string(16) |> String.pad_leading(2, "0")))
    |> String.downcase()
  end

  defp process_output(hash, :binary) do
    Enum.map_join(hash, &(&1 |> Integer.to_string(2) |> String.pad_leading(8, "0")))
  end

  defp parse(puzzle) do
    String.to_charlist(puzzle) ++ [17, 31, 73, 47, 23]
  end

  def checksum(list) do
    Enum.reduce(list, 0, &Bitwise.bxor/2)
  end
end
