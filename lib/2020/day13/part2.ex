defmodule Advent.Y2020.Day13.Part2 do
  def run(puzzle) do
    puzzle
    |> parse_schedule()
    |> find_sequence()
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

  def find_sequence(timetable) do
    timetable
    |> Enum.reduce({0, 1}, &add_to_sequence/2)
    |> elem(0)
  end

  defp add_to_sequence({bus, index}, {t, step}) do
    if Integer.mod(t + index, bus) == 0 do
      {t, lcm(step, bus)}
    else
      add_to_sequence({bus, index}, {t + step, step})
    end
  end

  defp lcm(a, b), do: div(a * b, Integer.gcd(a, b))
end
