defmodule Advent.Y2020.Day18.Part2 do
  alias Advent.Y2020.Day18.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn line -> Part1.evaluate(line, &evaluate_unparenthesed/1) end)
    |> Enum.sum()
  end

  def evaluate_unparenthesed(expression) do
    expression
    |> evaluate_operator("+")
    |> evaluate_operator("*")
  end

  def evaluate_operator(expression, operator) do
    Part1.recursive_replace(
      expression,
      Regex.compile!("\\d+ [\\#{operator}] \\d+"),
      &(&1 |> Code.eval_string() |> elem(0))
    )
  end
end
