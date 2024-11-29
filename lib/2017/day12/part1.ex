defmodule Advent.Y2017.Day12.Part1 do
  def run(puzzle) do
    puzzle
    |> parse()
    |> visit(0)
    |> length()
  end

  def parse(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.reduce(%{}, fn line, acc ->
      [input, outputs] = String.split(line, " <-> ")
      outputs = outputs |> String.split(", ") |> Enum.map(&String.to_integer/1)
      Map.put(acc, String.to_integer(input), outputs)
    end)
  end

  def visit(map, program, visited \\ []) do
    visited = [program | visited]
    outputs = Map.get(map, program) -- visited

    Enum.reduce(outputs, visited, fn program, visited ->
      visit(map, program, visited)
    end)
  end
end
