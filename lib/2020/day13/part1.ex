defmodule Advent.Y2020.Day13.Part1 do
  def run(puzzle) do
    {departure, timetable} = parse_schedule(puzzle)
    {bus_id, bus_departure} = find_earliest_bus(departure, timetable)

    (bus_departure - departure) * bus_id
  end

  def parse_schedule(puzzle) do
    [departure, timetable] = String.split(puzzle, "\n")

    timetable =
      timetable
      |> String.split(",")
      |> Enum.reject(&(&1 == "x"))
      |> Enum.map(&String.to_integer/1)

    {String.to_integer(departure), timetable}
  end

  def find_earliest_bus(departure, timetable) do
    timetable
    |> Enum.map(fn bus_id ->
      Stream.iterate({bus_id, 0}, fn {bus_id, time} ->
        {bus_id, time + bus_id}
      end)
    end)
    |> Enum.map(fn bus_iterator ->
      bus_iterator
      |> Stream.filter(fn {_, time} -> time >= departure end)
      |> Enum.at(0)
    end)
    |> Enum.min_by(&elem(&1, 1))
  end
end
