defmodule Advent.Y2019.Day12.Part2 do
  alias Advent.Y2019.Day12.Part1

  def run(puzzle) do
    planets = Part1.planet_map(puzzle)

    [period1, period2, period3] =
      for axis <- [:x, :y, :z] do
        Task.async(fn ->
          find_period_for_axis(planets, axis)
        end)
      end
      |> Enum.map(&Task.await/1)

    lcm(period1, lcm(period2, period3))
  end

  defp find_period_for_axis(planets, axis) do
    1
    |> Stream.iterate(&(&1 + 1))
    |> Enum.reduce_while({planets, %{planets => true}}, fn step, {planets, previous_planets} ->
      planets =
        planets
        |> Part1.update_velocity([axis])
        |> Part1.apply_movement([axis])

      case Map.get(previous_planets, planets) do
        nil -> {:cont, {planets, Map.put(previous_planets, planets, true)}}
        _ -> {:halt, step}
      end
    end)
  end

  def lcm(a, b), do: round(a * b / Integer.gcd(a, b))
end
