defmodule Advent.Y2023.Day03.Part2 do
  import Advent.Y2023.Day03.Part1
  alias Advent.Y2023.Day03.Part1.{Number, Symbol}

  def run(puzzle) do
    engine = parse(puzzle)
    number_map = build_number_map(engine)

    for %Symbol{kind: ?*, x: x, y: y} <- engine do
      adjacent_numbers(number_map, x, y)
    end
    |> Enum.filter(&(Enum.count(&1) >= 2))
    |> Enum.map(&Enum.product/1)
    |> Enum.sum()
  end

  defp build_number_map(engine) do
    for %Number{xs: xs, y: y, value: value} <- engine, x <- xs, reduce: %{} do
      acc -> Map.put(acc, {x, y}, value)
    end
  end

  defp adjacent_numbers(number_map, x, y) do
    for x <- (x - 1)..(x + 1),
        y <- (y - 1)..(y + 1),
        number = Map.get(number_map, {x, y}),
        number != nil,
        into: MapSet.new(),
        do: number
  end
end
