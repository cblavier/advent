defmodule Advent.Y2017.Day07.Part2 do
  alias Advent.Y2017.Day07.Part1
  alias Advent.Y2017.Day07.Part1.Program

  def run(puzzle) do
    programs =
      for program <- Part1.parse(puzzle), reduce: %{} do
        acc -> Map.put(acc, program.name, program)
      end

    root_name = programs |> Map.values() |> Part1.find_root()

    programs
    |> Map.get(root_name)
    |> program_weight(programs)
    |> elem(1)
  end

  def program_weight(%Program{parents: parents, weight: weight}, programs) do
    parents_with_weight =
      for parent <- parents, program = Map.get(programs, parent) do
        {program, program_weight(program, programs)}
      end

    Enum.reduce(parents_with_weight, {:ok, []}, fn
      _item, {:imbalance, imbalance} when is_integer(imbalance) ->
        {:imbalance, imbalance}

      {_parent, {:imbalance, imbalance}}, _acc ->
        {:imbalance, imbalance}

      {parent, {:ok, weight}}, {:imbalance, parents_with_weight} ->
        {:imbalance, [{parent, weight} | parents_with_weight]}

      {parent, {:ok, weight}}, {:ok, []} ->
        {:ok, [{parent, weight}]}

      {parent, {:ok, weight}}, {:ok, parents_with_weight} ->
        weights = Enum.map(parents_with_weight, &elem(&1, 1))

        if Enum.member?(weights, weight) do
          {:ok, [{parent, weight} | parents_with_weight]}
        else
          {:imbalance, [{parent, weight} | parents_with_weight]}
        end
    end)
    |> then(fn
      {:ok, parents_with_weight} ->
        {:ok, weight + (parents_with_weight |> Enum.map(&elem(&1, 1)) |> Enum.sum())}

      {:imbalance, parents_with_weight} when is_list(parents_with_weight) ->
        {:imbalance, fix_imbalance(parents_with_weight)}

      {:imbalance, imbalance} ->
        {:imbalance, imbalance}
    end)
  end

  def fix_imbalance(parents_with_weight) do
    %{:good => {_good_prog, good_weight}, :outlier => {outlier_prog, outlier_weight}} =
      parents_with_weight
      |> Enum.group_by(&elem(&1, 1))
      |> Enum.reduce(%{good: [], outlier: nil}, fn
        {_, [parent_with_weight]}, acc -> Map.put(acc, :outlier, parent_with_weight)
        {_, parents_with_weight}, acc -> Map.put(acc, :good, hd(parents_with_weight))
      end)

    imbalance = outlier_weight - good_weight
    outlier_prog.weight - imbalance
  end
end
