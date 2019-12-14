defmodule Advent.Y2019.Day14.Part2 do
  alias Advent.Y2019.Day14.Part1

  def run(puzzle, ore) do
    formulas = Part1.parse_formulas(puzzle)
    fuel_step = 1

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while({%{"ORE" => ore}, fuel_step, 0}, fn _i, {leftovers, fuel_step, fuel} ->
      case Part1.produce(formulas, {"FUEL", fuel_step}, leftovers) do
        {%{"ORE" => amount}, _leftovers} when amount > 0 and fuel_step == 1 ->
          {:halt, fuel}

        {%{"ORE" => amount}, _leftovers} when amount > 0 ->
          {:cont, {leftovers, div(fuel_step, 10), fuel}}

        {_, leftovers} ->
          {:cont, {leftovers, fuel_step * 10, fuel + fuel_step}}
      end
    end)
  end
end
