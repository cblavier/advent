defmodule Advent.Y2022.Day16.Part1 do
  def run(puzzle) do
    puzzle
    |> build_graph()
    |> floyd_warshall()
    |> remove_broken_valves()
    |> walk_cave("AA", 30)
  end

  def build_graph(puzzle) do
    for line <- String.split(puzzle, "\n"), reduce: {%{}, %{}} do
      {graph, valves} ->
        [valve, rate, neighbors] =
          Regex.run(~r|Valve (\w+) has flow rate=(\d+); tunnels? leads? to valves? (.*)|, line,
            capture: :all_but_first
          )

        graph =
          for neighbor <- String.split(neighbors, ", "), reduce: graph do
            graph -> Map.put(graph, {valve, neighbor}, 1)
          end

        {
          Map.put(graph, {valve, valve}, 0),
          Map.put(valves, valve, String.to_integer(rate))
        }
    end
  end

  @infinity 9999
  def floyd_warshall({graph, valves}) do
    valve_names = Map.keys(valves)

    graph =
      for vk <- valve_names, reduce: graph do
        prev_graph ->
          for vi <- valve_names, vj <- valve_names, reduce: prev_graph do
            next_graph ->
              ij = Map.get(prev_graph, {vi, vj}, @infinity)
              ik = Map.get(prev_graph, {vi, vk}, @infinity)
              kj = Map.get(prev_graph, {vk, vj}, @infinity)
              Map.put(next_graph, {vi, vj}, min(ij, ik + kj))
          end
      end

    {graph, valves}
  end

  def remove_broken_valves({graph, valves}) do
    {graph, valves |> Enum.reject(fn {_v, rate} -> rate == 0 end) |> Enum.into(%{})}
  end

  defp walk_cave(graph_and_valves, valve, remaining_time, released_pressure \\ 0)
  defp walk_cave({_, valves}, _, _, released_pressure) when valves == %{}, do: released_pressure

  defp walk_cave({graph, valves}, valve, remaining_time, released_pressure) do
    valves
    |> Enum.map(fn {next_valve, rate} ->
      valves = Map.delete(valves, next_valve)
      time_to_valve = Map.get(graph, {valve, next_valve})

      if (remaining_time = remaining_time - time_to_valve - 1) >= 0 do
        walk_cave(
          {graph, valves},
          next_valve,
          remaining_time,
          released_pressure + rate * remaining_time
        )
      else
        released_pressure
      end
    end)
    |> Enum.max()
  end
end
