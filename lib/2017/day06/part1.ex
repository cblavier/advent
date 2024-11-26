defmodule Advent.Y2017.Day06.Part1 do
  def run(puzzle) do
    config = parse(puzzle)

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while({config, MapSet.new([config])}, fn i, {config, prev} ->
      config = reallocate(config)

      if MapSet.member?(prev, config) do
        {:halt, i}
      else
        {:cont, {config, MapSet.put(prev, config)}}
      end
    end)
  end

  def parse(puzzle) do
    puzzle
    |> String.split([" ", "\t"])
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {n, i}, acc ->
      Map.put(acc, i, n)
    end)
  end

  def reallocate(config) do
    {max_pos, max} =
      for {i, val} <- config, reduce: {nil, 0} do
        {max_i, max} -> if val > max, do: {i, val}, else: {max_i, max}
      end

    length = Enum.count(config)
    div = div(max, length)

    config =
      config
      |> Map.put(max_pos, 0)
      |> Enum.reduce(%{}, fn {i, val}, acc -> Map.put(acc, i, val + div) end)

    case rem(max, length) do
      0 ->
        config

      rem ->
        Enum.reduce((max_pos + 1)..(max_pos + rem), config, fn pos, config ->
          Map.update!(config, rem(pos, length), &(&1 + 1))
        end)
    end
  end
end
