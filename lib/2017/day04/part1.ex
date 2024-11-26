defmodule Advent.Y2017.Day04.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.filter(&validate_passphrase/1)
    |> Enum.count()
  end

  def validate_passphrase(passphrase) do
    passphrase
    |> String.split(" ")
    |> Enum.frequencies()
    |> Enum.all?(fn {_word, count} -> count == 1 end)
  end
end
