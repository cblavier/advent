defmodule Advent.Y2017.Day14.Part1 do
  alias Advent.Y2017.Day10.Part2, as: KnotHash

  def run(puzzle) do
    Task.async_stream(0..127, fn i ->
      hash = KnotHash.run("#{puzzle}-#{i}", :binary)
      hash |> String.graphemes() |> Enum.count(&(&1 == "1"))
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end
end
