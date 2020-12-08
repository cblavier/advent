defmodule Advent.Y2020.Day08.Part2 do
  alias Advent.Y2020.Day08.Part1

  def run(puzzle) do
    puzzle
    |> Part1.parse_program()
    |> run_variations()
    |> elem(0)
  end

  def run_variations(program) do
    0..(Enum.count(program) - 1)
    |> Stream.map(&Map.put(program, &1, {"nop", 0}))
    |> Stream.map(&Part1.run_program/1)
    |> Stream.filter(fn
      {_acc, :cycle} -> false
      {_acc, :end} -> true
    end)
    |> Enum.take(1)
    |> hd()
  end
end
