defmodule Advent.Y2018.Day07.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> parse()
    |> traverse()
    |> Enum.join()
  end

  @doc ~S"""
  iex> import Advent.Y2018.Day07.Part1
  iex> parse([
  ...>   "Step C must be finished before step A can begin.",
  ...>   "Step C must be finished before step F can begin.",
  ...>   "Step A must be finished before step B can begin.",
  ...>   "Step A must be finished before step D can begin.",
  ...>   "Step B must be finished before step E can begin.",
  ...>   "Step D must be finished before step E can begin.",
  ...>   "Step F must be finished before step E can begin."
  ...> ])
  {
    %{
      "A" => {["C"], ["B", "D"]},
      "B" => {["A"], ["E"]},
      "C" => {[], ["A", "F"]},
      "D" => {["A"], ["E"]},
      "E" => {["B", "D", "F"], []},
      "F" => {["C"], ["E"]}
    },
    ["C"]
  }
  """
  def parse(puzzle) do
    {graph, nodes, not_starts} =
      Enum.reduce(puzzle, {%{}, MapSet.new(), MapSet.new()}, fn puzzle_entry,
                                                                {graph, nodes, not_starts} ->
        {prereq, next} = parse_puzzle_entry(puzzle_entry)

        graph =
          graph
          |> Map.update(next, {[prereq], []}, fn {prereqs, nexts} ->
            {[prereq | prereqs], nexts}
          end)
          |> Map.update(prereq, {[], [next]}, fn {prereqs, nexts} ->
            {prereqs, [next | nexts]}
          end)

        nodes = nodes |> MapSet.put(next) |> MapSet.put(prereq)
        not_starts = MapSet.put(not_starts, next)

        {graph, nodes, not_starts}
      end)

    graph =
      for {step, {prereqs, nexts}} <- graph, into: %{} do
        {step, {Enum.sort(prereqs), Enum.sort(nexts)}}
      end

    starts = nodes |> MapSet.difference(not_starts) |> Enum.sort()
    {graph, starts}
  end

  @regex Regex.compile!(~S/Step (?<prereq>\w) must .* step (?<step>\w) can begin./)
  @doc ~S"""
  iex> import Advent.Y2018.Day07.Part1
  iex> parse_puzzle_entry("Step Z must be finished before step A can begin.")
  {"Z", "A"}
  """
  def parse_puzzle_entry(step) do
    %{"prereq" => prereq, "step" => step} = Regex.named_captures(@regex, step)
    {prereq, step}
  end

  @doc ~S"""
  iex> import Advent.Y2018.Day07.Part1
  iex> traverse({
  ...>  %{
  ...>    "A" => {["C"], ["B", "D"]},
  ...>    "B" => {["A"], ["E"]},
  ...>    "C" => {[], ["A", "F"]},
  ...>    "D" => {["A"], ["E"]},
  ...>    "E" => {["B", "D", "F"], []},
  ...>    "F" => {["C"], ["E"]}
  ...>  },
  ...>  ["C"]
  ...> })
  ["C", "A", "B", "D", "F", "E"]
  """
  def traverse(graph_and_available_nodes, traversed \\ [])
  def traverse({_graph, []}, traversed), do: Enum.reverse(traversed)

  def traverse({graph, available_nodes}, traversed) do
    [new_node | available_nodes] = available_nodes
    nexts = graph |> Map.get(new_node) |> elem(1)

    {graph, available_nodes} =
      Enum.reduce(nexts, {graph, available_nodes}, fn next, {graph, available_nodes} ->
        next_prereqs = graph |> Map.get(next) |> elem(0) |> Enum.reject(&(&1 == new_node))

        available_nodes =
          case next_prereqs do
            [] -> Enum.sort([next | available_nodes])
            _ -> available_nodes
          end

        graph = Map.update!(graph, next, fn {_prereqs, nexts} -> {next_prereqs, nexts} end)
        {graph, available_nodes}
      end)

    traverse({graph, available_nodes}, [new_node | traversed])
  end
end
