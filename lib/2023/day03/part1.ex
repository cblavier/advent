defmodule Advent.Y2023.Day03.Part1 do
  defmodule Number do
    defstruct value: 0, xs: [], y: nil
  end

  defmodule Symbol do
    defstruct [:kind, :x, :y]
  end

  def run(puzzle) do
    engine = parse(puzzle)
    symbol_map = build_symbol_map(engine)

    engine
    |> find_part_numbers(symbol_map)
    |> Enum.sum()
  end

  def parse(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.reduce({%Number{y: y}, []}, fn
        {c, x}, {cur, acc} when c in ?0..?9 ->
          {%Number{value: 10 * cur.value + c - ?0, xs: [x | cur.xs], y: y}, acc}

        {?., _x}, {%Number{value: 0}, acc} ->
          {%Number{y: y}, acc}

        {?., _x}, {number, acc} ->
          {%Number{y: y}, [number | acc]}

        {c, x}, {%Number{value: 0}, acc} ->
          {%Number{y: y}, [%Symbol{kind: c, x: x, y: y} | acc]}

        {c, x}, {number, acc} ->
          {%Number{y: y}, [%Symbol{kind: c, x: x, y: y}, number | acc]}
      end)
      |> then(&[elem(&1, 0) | elem(&1, 1)])
    end)
  end

  defp build_symbol_map(engine) do
    for %Symbol{x: x, y: y} <- engine, reduce: %{} do
      acc -> Map.put(acc, {x, y}, true)
    end
  end

  defp find_part_numbers(engine, symbol_map) do
    for %Number{xs: xs, y: y, value: value} <- engine,
        Enum.any?(xs, &has_adjacent_symbol?(&1, y, symbol_map)) do
      value
    end
  end

  defp has_adjacent_symbol?(x, y, symbol_map) do
    for(x <- (x - 1)..(x + 1), y <- (y - 1)..(y + 1), do: {x, y})
    |> Enum.any?(fn {x, y} -> Map.has_key?(symbol_map, {x, y}) end)
  end
end
