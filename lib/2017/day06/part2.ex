defmodule Advent.Y2017.Day06.Part2 do
  alias Advent.Y2017.Day06.Part1

  def run(puzzle) do
    config = Part1.parse(puzzle)

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while({config, %{config => 0}}, fn i, {config, acc} ->
      config = Part1.reallocate(config)

      case Map.get(acc, config) do
        nil -> {:cont, {config, Map.put(acc, config, i)}}
        j -> {:halt, i - j}
      end
    end)
  end
end
