defmodule Advent.Puzzle do
  def load(year, day, name \\ "puzzle.txt") do
    day = "day#{String.pad_leading(to_string(day), 2, "0")}"

    "../fixtures/#{year}/#{day}/#{name}"
    |> Path.expand(__DIR__)
    |> File.read!()
  end
end
