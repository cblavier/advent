defmodule Advent.Y2018.Day05.Part2 do
  alias Advent.Y2018.Day05.Part1

  def run(puzzle) do
    ?a..?z
    |> Enum.map(&to_string([&1]))
    |> Task.async_stream(
      fn c ->
        puzzle
        |> String.replace([c, String.upcase(c)], "")
        |> String.to_charlist()
        |> Part1.resolve()
        |> Enum.count()
      end,
      timeout: :infinity
    )
    |> Enum.map(&elem(&1, 1))
    |> Enum.min()
  end
end
