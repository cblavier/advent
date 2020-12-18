defmodule Advent.Y2020.Day18.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn line -> evaluate(line, &evaluate_unparenthesed/1) end)
    |> Enum.sum()
  end

  def evaluate(expr, evaluate_unparenthesed) do
    recursive_replace(
      expr,
      ~r|\([^\(\)]*\)|,
      &(&1 |> String.replace(["(", ")"], "") |> evaluate_unparenthesed.())
    )
    |> evaluate_unparenthesed.()
    |> String.to_integer()
  end

  def evaluate_unparenthesed(expression) do
    recursive_replace(
      expression,
      ~r|\d+ [\+\*] \d+|,
      &(&1 |> Code.eval_string() |> elem(0))
    )
  end

  def recursive_replace(expression, regex, replace_fun) do
    case Regex.run(regex, expression) do
      [match | _] ->
        result = match |> replace_fun.() |> to_string()

        regex
        |> Regex.replace(expression, result, global: false)
        |> recursive_replace(regex, replace_fun)

      _ ->
        String.trim(expression)
    end
  end
end
