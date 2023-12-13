defmodule Advent.Y2022.Day16.Part2 do
  import Advent.Y2022.Day16.Part1

  def run(puzzle) do
    puzzle
    |> build_graph()
    |> floyd_warshall()
    |> remove_broken_valves()
    |> set_unreachable_markers()
    |> walk_cave({"AA", "AA"}, {26, 26})
  end

  defp set_unreachable_markers({graph, valves}) do
    valves =
      for {key, valve_rate} <- valves, into: %{} do
        {key, %{rate: valve_rate, blocked_for_me: false, blocked_for_elephant: false}}
      end

    {graph, valves}
  end

  defp walk_cave(graph_and_valves, positions, remaining_times, released_pressure \\ 0)
  defp walk_cave({_, valves}, _, _, released_pressure) when valves == %{}, do: released_pressure

  defp walk_cave(
         {graph, valves},
         {my_valve, elephant_valve},
         {my_remaining_time, elephant_remaining_time},
         released_pressure
       ) do
    for {my_next_valve, my_next_valve_details} <- valves,
        {elephant_next_valve, elephant_next_valve_details} <- valves,
        not my_next_valve_details.blocked_for_me,
        not elephant_next_valve_details.blocked_for_elephant,
        my_next_valve != elephant_next_valve do
      my_time_to_valve = Map.get(graph, {my_valve, my_next_valve})
      elephant_time_to_valve = Map.get(graph, {elephant_valve, elephant_next_valve})

      {released_pressure, my_remaining_time, my_next_valve, valves} =
        if my_time_to_valve + 1 < my_remaining_time do
          my_remaining_time = my_remaining_time - my_time_to_valve - 1

          {
            released_pressure + my_next_valve_details.rate * my_remaining_time,
            my_remaining_time,
            my_next_valve,
            Map.delete(valves, my_next_valve)
          }
        else
          {released_pressure, my_remaining_time, my_valve,
           Map.update!(valves, my_next_valve, &%{&1 | blocked_for_me: true})}
        end

      {released_pressure, elephant_remaining_time, elephant_next_valve, valves} =
        if elephant_time_to_valve + 1 < elephant_remaining_time do
          elephant_remaining_time = elephant_remaining_time - elephant_time_to_valve - 1

          {
            released_pressure + elephant_next_valve_details.rate * elephant_remaining_time,
            elephant_remaining_time,
            elephant_next_valve,
            Map.delete(valves, elephant_next_valve)
          }
        else
          {released_pressure, elephant_remaining_time, elephant_valve,
           Map.update!(valves, elephant_next_valve, &%{&1 | blocked_for_elephant: true})}
        end

      if my_valve != my_next_valve or elephant_valve != elephant_next_valve do
        valves =
          valves
          |> Enum.reject(fn {_, v} -> v.blocked_for_me and v.blocked_for_elephant end)
          |> Enum.into(%{})

        walk_cave(
          {graph, valves},
          {my_next_valve, elephant_next_valve},
          {my_remaining_time, elephant_remaining_time},
          released_pressure
        )
      else
        released_pressure
      end
    end
    |> max()
  end

  defp max([]), do: 0
  defp max(list), do: Enum.max(list)
end
