defmodule Advent.Y2015.Day17.Part1 do
  @target 150

  def run(puzzle) do
    puzzle
    |> buckets()
    |> combinations_for_target(@target)
    |> length()
  end

  def buckets(puzzle) do
    for n <- String.split(puzzle, "\n"),
        do: String.to_integer(n)
  end

  def combinations_for_target(buckets, target) do
    1..length(buckets)
    |> Task.async_stream(fn n ->
      buckets
      |> combinations(n)
      |> Enum.filter(&(Enum.sum(&1) == target))
    end)
    |> Enum.flat_map(&elem(&1, 1))
  end

  def combinations(_, 0), do: [[]]
  def combinations([], _), do: []

  def combinations([head | tail], n) do
    for(rest <- combinations(tail, n - 1), do: [head | rest]) ++
      combinations(tail, n)
  end
end
