defmodule Advent.Y2018.Day07.Part2 do
  alias Advent.Y2018.Day07.Part1

  def run(puzzle, worker_count, base_duration) do
    puzzle
    |> String.split("\n")
    |> Part1.parse()
    |> add_duration(base_duration)
    |> traverse(worker_count, base_duration)
  end

  defp add_duration({graph, available_nodes}, base_duration) do
    available_nodes = Enum.map(available_nodes, &{&1, node_duration(&1, base_duration)})
    {graph, available_nodes, []}
  end

  @doc ~S"""
  iex> import Advent.Y2018.Day07.Part2
  iex> traverse(
  ...>   {
  ...>     %{
  ...>       "A" => {["C"], ["B", "D"]},
  ...>       "B" => {["A"], ["E"]},
  ...>       "C" => {[], ["A", "F"]},
  ...>       "D" => {["A"], ["E"]},
  ...>       "E" => {["B", "D", "F"], []},
  ...>       "F" => {["C"], ["E"]}
  ...>     },
  ...>    [{"C", 3}],
  ...>    []
  ...>   },
  ...>   2, 0
  ...> )
  15
  """
  def traverse(graph_and_available_nodes, worker_count, base_duration, total_duration \\ 0)

  def traverse({_graph, [], []}, _worker_count, _base_duration, total_duration),
    do: total_duration

  def traverse(
        {graph, available_nodes, working_nodes},
        worker_count,
        base_duration,
        total_duration
      ) do
    available_worker_count = worker_count - length(working_nodes)
    {new_working_nodes, available_nodes} = npop(available_nodes, available_worker_count)
    working_nodes = working_nodes ++ new_working_nodes

    {finished_nodes, still_working_nodes} =
      Enum.reduce(working_nodes, {[], []}, fn
        {node, 1}, {finished_nodes, working_nodes} ->
          {[node | finished_nodes], working_nodes}

        {node, duration}, {finished_nodes, working_nodes} ->
          {finished_nodes, [{node, duration - 1} | working_nodes]}
      end)

    {graph, available_nodes} =
      Enum.reduce(finished_nodes, {graph, available_nodes}, fn node, {graph, available_nodes} ->
        nexts = graph |> Map.get(node) |> elem(1)

        Enum.reduce(nexts, {graph, available_nodes}, fn next, {graph, available_nodes} ->
          next_prereqs = graph |> Map.get(next) |> elem(0) |> Enum.reject(&(&1 == node))

          available_nodes =
            case next_prereqs do
              [] ->
                next_duration = node_duration(next, base_duration)
                Enum.sort([{next, next_duration} | available_nodes])

              _ ->
                available_nodes
            end

          graph = Map.update!(graph, next, fn {_prereqs, nexts} -> {next_prereqs, nexts} end)
          {graph, available_nodes}
        end)
      end)

    traverse(
      {graph, available_nodes, still_working_nodes},
      worker_count,
      base_duration,
      total_duration + 1
    )
  end

  @doc ~S"""
  iex> import Advent.Y2018.Day07.Part2
  iex> node_duration("C", 30)
  33
  """
  def node_duration(node, base_duration) do
    char = node |> String.to_charlist() |> hd()
    char - ?A + base_duration + 1
  end

  @doc ~S"""
  iex> import Advent.Y2018.Day07.Part2
  iex> npop([], 1)
  {[], []}
  iex> npop(["a", "b", "c"], 1)
  {["a"], ["b", "c"]}
  iex> npop(["a", "b", "c"], 2)
  {["a", "b"], ["c"]}
  iex> npop(["a", "b", "c"], 3)
  {["a", "b", "c"], []}
  iex> npop(["a", "b", "c"], 4)
  {["a", "b", "c"], []}
  """
  def npop(list, n) do
    {
      Enum.slice(list, 0, n),
      Enum.slice(list, n..-1//1)
    }
  end
end
