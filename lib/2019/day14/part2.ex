defmodule Advent.Y2019.Day14.Part2 do
  alias Advent.Y2019.Day14.Part1

  @initial 1
  @step_ratio 10

  def run(puzzle, ore) do
    formulas = Part1.parse_formulas(puzzle)

    Stream.repeatedly(fn -> :ok end)
    |> Enum.reduce_while({%{"ORE" => ore}, @initial, 0}, fn _, {leftovers, fuel_step, fuel} ->
      case Part1.produce(formulas, {"FUEL", fuel_step}, leftovers) do
        {%{"ORE" => amount}, _leftovers} when amount > 0 and fuel_step == 1 ->
          {:halt, fuel}

        {%{"ORE" => amount}, _leftovers} when amount > 0 ->
          {:cont, {leftovers, adjust_fuel_step(fuel_step, :down), fuel}}

        {_, leftovers} ->
          {:cont, {leftovers, adjust_fuel_step(fuel_step, :up), fuel + fuel_step}}
      end
    end)
  end

  defp adjust_fuel_step(current, :up), do: current * @step_ratio
  defp adjust_fuel_step(current, :down), do: div(current, @step_ratio)
end
