defmodule Advent.Y2019.Day12.Part2 do
  alias Advent.Y2019.Day12.Part1

  def run(puzzle) do
    planets = puzzle |> String.split("\n") |> Enum.map(&Part1.parse_planet/1)

    [period1, period2, period3] =
      for axis <- 0..2 do
        Task.async(fn -> find_period_for_axis(planets, planets, axis, 0) end)
      end
      |> Enum.map(&Task.await/1)

    lcm(period1, lcm(period2, period3))
  end

  defp find_period_for_axis(planets, planets, _axis, step) when step > 0, do: step

  defp find_period_for_axis(planets, target, axis, step) do
    next_planets = planets |> Part1.update_velocity([axis]) |> Part1.apply_movement([axis])
    find_period_for_axis(next_planets, target, axis, step + 1)
  end

  def lcm(a, b), do: div(a * b, Integer.gcd(a, b))
end
