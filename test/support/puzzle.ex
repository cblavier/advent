defmodule Advent.Puzzle do
  def load(year, day, name \\ "puzzle.txt") do
    "../fixtures/#{year}/day#{day}/#{name}"
    |> Path.expand(__DIR__)
    |> File.read!()
  end
end
