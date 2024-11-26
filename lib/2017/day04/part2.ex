defmodule Advent.Y2017.Day04.Part2 do
  alias Advent.Y2017.Day04.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&sort_passphrase_words/1)
    |> Enum.filter(&Part1.validate_passphrase/1)
    |> Enum.count()
  end

  defp sort_passphrase_words(passphrase) do
    passphrase
    |> String.split(" ")
    |> Enum.map_join(" ", fn word ->
      word |> String.graphemes() |> Enum.sort() |> Enum.join()
    end)
  end
end
