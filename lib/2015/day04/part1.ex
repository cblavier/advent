defmodule Advent.Y2015.Day04.Part1 do
  def run(puzzle) do
    find_number(puzzle, "00000")
  end

  def find_number(puzzle, target) do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&{&1, puzzle <> to_string(&1)})
    |> Stream.map(fn {i, input} -> {i, md5(input)} end)
    |> Stream.filter(fn {_, md5} -> String.starts_with?(md5, target) end)
    |> Enum.at(0)
    |> elem(0)
  end

  def md5(input) do
    :crypto.hash(:md5, input) |> Base.encode16()
  end
end
