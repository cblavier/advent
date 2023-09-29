defmodule Advent.Y2022.Day15.Part1 do
  @y_target 2_000_000

  def run(puzzle) do
    puzzle
    |> parse_instructions()
    |> get_beacon_exclusions(@y_target)
    |> MapSet.size()
  end

  def parse_instructions(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn s ->
      [sensor_x, sensor_y, beacon_x, beacon_y] =
        Regex.run(~r|Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)|, s,
          capture: :all_but_first
        )

      [
        {String.to_integer(sensor_x), String.to_integer(sensor_y)},
        {String.to_integer(beacon_x), String.to_integer(beacon_y)}
      ]
    end)
  end

  defp get_beacon_exclusions(instructions, y) do
    instructions
    |> Task.async_stream(fn [{sensor_x, sensor_y}, {beacon_x, beacon_y}] ->
      distance = abs(beacon_x - sensor_x) + abs(beacon_y - sensor_y)
      y_distance = abs(sensor_y - y)

      if y_distance <= distance do
        max_x_distance = distance - y_distance

        for x <- (sensor_x - max_x_distance)..(sensor_x + max_x_distance),
            x != beacon_x or y != beacon_y,
            into: MapSet.new() do
          {x, y}
        end
      else
        MapSet.new()
      end
    end)
    |> Stream.map(&elem(&1, 1))
    |> Enum.reduce(MapSet.new(), &MapSet.union/2)
  end
end
