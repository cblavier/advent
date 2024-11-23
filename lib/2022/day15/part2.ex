defmodule Advent.Y2022.Day15.Part2 do
  import Advent.Y2022.Day15.Part1
  @max_xy 4_000_000

  def run(puzzle) do
    instructions = parse_instructions(puzzle)

    @max_xy..0//-1
    |> Task.async_stream(&{get_beacon_exclusions(instructions, &1), &1})
    |> Stream.map(&elem(&1, 1))
    |> Stream.reject(fn
      {[], _y} -> true
      _ -> false
    end)
    |> Stream.take(1)
    |> Enum.at(0)
    |> then(fn {[x..x//_], y} -> x * @max_xy + y end)
  end

  defp get_beacon_exclusions(instructions, y) do
    instructions
    |> Stream.map(fn [{sensor_x, sensor_y}, {beacon_x, beacon_y}] ->
      distance = abs(beacon_x - sensor_x) + abs(beacon_y - sensor_y)
      y_distance = abs(sensor_y - y)

      if y_distance <= distance do
        max_x_distance = distance - y_distance
        (sensor_x - max_x_distance)..(sensor_x + max_x_distance)
      else
        nil
      end
    end)
    |> Stream.reject(&is_nil/1)
    |> Enum.reduce([0..@max_xy], fn range = r1..r2//_, acc ->
      Enum.flat_map(acc, fn acc = a1..a2//_ ->
        cond do
          acc == [] -> []
          Range.disjoint?(acc, range) -> [acc]
          r1 <= a1 and r2 >= a2 -> []
          a1 < r1 and a2 > r2 -> [a1..(r1 - 1), (r2 + 1)..a2]
          a1 < r1 and r2 >= a2 -> [a1..(r1 - 1)]
          a1 >= r1 and r2 < a2 -> [(r2 + 1)..a2]
        end
      end)
    end)
  end
end
