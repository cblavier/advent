defmodule Advent.Y2017.Day05.Part2 do
  alias Advent.Y2017.Day05.Part1

  def run(puzzle) do
    puzzle = Part1.parse(puzzle)

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({puzzle, 0}, fn i, {puzzle, pos} ->
      case Map.get(puzzle, pos) do
        nil ->
          {:halt, i}

        offset when offset >= 3 ->
          puzzle = Map.update!(puzzle, pos, &(&1 - 1))
          {:cont, {puzzle, pos + offset}}

        offset ->
          puzzle = Map.update!(puzzle, pos, &(&1 + 1))
          {:cont, {puzzle, pos + offset}}
      end
    end)
  end
end
