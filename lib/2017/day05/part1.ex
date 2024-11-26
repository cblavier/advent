defmodule Advent.Y2017.Day05.Part1 do
  def run(puzzle) do
    puzzle = parse(puzzle)

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({puzzle, 0}, fn i, {puzzle, pos} ->
      case Map.get(puzzle, pos) do
        nil ->
          {:halt, i}

        offset ->
          puzzle = Map.update!(puzzle, pos, &(&1 + 1))
          {:cont, {puzzle, pos + offset}}
      end
    end)
  end

  def parse(puzzle) do
    puzzle
    |> String.split(["\n", " "])
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {n, i}, acc ->
      Map.put(acc, i, n)
    end)
  end
end
