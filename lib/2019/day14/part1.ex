defmodule Advent.Y2019.Day14.Part1 do
  def run(puzzle) do
    puzzle
    |> parse_formulas()
    |> produce({"FUEL", 1})
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day14.Part1
  iex> formulas = %{}
  iex> formulas = Map.put(formulas, "A", {10, [{"ORE", 10}]})
  iex> formulas = Map.put(formulas, "B", {1, [{"ORE", 1}]})
  iex> formulas = Map.put(formulas, "C", {1, [{"A", 7}, {"B", 1}]})
  iex> formulas = Map.put(formulas, "D", {1, [{"A", 7}, {"C", 1}]})
  iex> formulas = Map.put(formulas, "E", {1, [{"A", 7}, {"D", 1}]})
  iex> formulas = Map.put(formulas, "FUEL", {1, [{"A", 7}, {"E", 1}]})
  iex> Part1.produce(formulas, {"FUEL", 1})
  {%{"ORE" => 31}, %{"A" => 2, "B" => 0, "C" => 0, "D" => 0, "E" => 0, "FUEL" => 0, "ORE" => 0}}
  """
  def produce(formulas, target, leftovers \\ %{})

  def produce(_formulas, {target_chemical = "ORE", target_amount}, leftovers) do
    {target_amount, leftovers} = pick_in_leftovers(target_chemical, target_amount, leftovers)
    {%{"ORE" => target_amount}, leftovers}
  end

  def produce(formulas, {target_chemical, target_amount}, leftovers) do
    {target_amount, leftovers} = pick_in_leftovers(target_chemical, target_amount, leftovers)
    {produced, reactions} = Map.get(formulas, target_chemical)
    reactions_count = round(Float.ceil(target_amount / produced))

    {requirements, leftovers} =
      Enum.reduce(reactions, {%{}, leftovers}, fn {chemical, amount}, {acc, leftovers} ->
        {requirements, leftovers} =
          produce(formulas, {chemical, amount * reactions_count}, leftovers)

        {Map.merge(requirements, acc, fn _k, v1, v2 -> v1 + v2 end), leftovers}
      end)

    {
      requirements,
      stash_in_leftovers(target_chemical, reactions_count * produced - target_amount, leftovers)
    }
  end

  defp pick_in_leftovers(target_chemical, amount, leftovers) do
    leftovers
    |> Map.get_and_update(target_chemical, fn
      nil -> {amount, 0}
      leftover when amount >= leftover -> {amount - leftover, 0}
      leftover -> {0, leftover - amount}
    end)
  end

  defp stash_in_leftovers(target_chemical, amount, leftovers) do
    Map.update(leftovers, target_chemical, amount, &(&1 + amount))
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day14.Part1
  iex> puzzle = ""
  iex> puzzle = puzzle <> "10 ORE => 10 A\n"
  iex> puzzle = puzzle <> "1 ORE => 1 B\n"
  iex> puzzle = puzzle <> "7 A, 1 B => 1 C\n"
  iex> puzzle = puzzle <> "7 A, 1 C => 1 D\n"
  iex> puzzle = puzzle <> "7 A, 1 D => 1 E\n"
  iex> puzzle = puzzle <> "7 A, 1 E => 1 FUEL"
  iex> Part1.parse_formulas(puzzle)
  %{
    "A" => {10, [{"ORE", 10}]},
    "B" => {1, [{"ORE", 1}]},
    "C" => {1, [{"A", 7}, {"B", 1}]},
    "D" => {1, [{"A", 7}, {"C", 1}]},
    "E" => {1, [{"A", 7}, {"D", 1}]},
    "FUEL" => {1, [{"A", 7}, {"E", 1}]}
  }
  """
  def parse_formulas(puzzle) do
    for line <- String.split(puzzle, "\n"), into: %{} do
      [inputs, output] = String.split(line, "=>")

      inputs =
        for input <- String.split(inputs, ",") do
          [amount, chemical] = String.split(input)
          {chemical, String.to_integer(amount)}
        end

      [amount, chemical] = String.split(output)
      {chemical, {String.to_integer(amount), inputs}}
    end
  end
end
