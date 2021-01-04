defmodule Advent.Y2015.Day08.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&(escaped_length(&1) - String.length(&1)))
    |> Enum.sum()
  end

  def escaped_length(line) do
    escaped = line |> String.replace(~s(\\), ~s(\\\\)) |> String.replace(~s(\"), ~s(\\"))
    String.length(escaped) + 2
  end
end
