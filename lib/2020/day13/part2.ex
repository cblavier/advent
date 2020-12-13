defmodule Advent.Y2020.Day13.Part2 do
  def run(puzzle) do
    puzzle
    |> parse_schedule()
    |> Enum.reduce({0, 1}, &find_sequence/2)
    |> elem(0)
  end

  def parse_schedule(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.at(1)
    |> String.split(",")
    |> Enum.with_index()
    |> Enum.map(fn
      {"x", _} -> nil
      {bus_id, index} -> {String.to_integer(bus_id), index}
    end)
    |> Enum.reject(&is_nil/1)
  end

  defp find_sequence({bus_id, index}, {time, step}) do
    if rem(time + index, bus_id) == 0 do
      {time, lcm(step, bus_id)}
    else
      find_sequence({bus_id, index}, {time + step, step})
    end
  end

  defp lcm(a, b), do: div(a * b, Integer.gcd(a, b))
end
