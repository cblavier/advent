defmodule Advent.Y2020.Day08.Part2 do
  alias Advent.Y2020.Day08.Part1

  def run(puzzle) do
    puzzle
    |> Part1.parse_program()
    |> run_variations()
    |> elem(0)
  end

  def run_variations(program) do
    {_, :cycle, visited} = Part1.run_program(program)

    visited
    |> Stream.map(
      &Map.update!(program, &1, fn
        {"nop", count} -> {"jmp", count}
        {"jmp", _count} -> {"nop", 0}
        other -> other
      end)
    )
    |> Stream.map(&Part1.run_program/1)
    |> Stream.filter(fn
      {_acc, :cycle, _} -> false
      {_acc, :end, _} -> true
    end)
    |> Enum.take(1)
    |> hd()
  end
end
