defmodule Advent.Y2024.Day07.Part2 do
  alias Advent.Y2024.Day07.Part1

  def run(puzzle) do
    puzzle
    |> Part1.parse()
    |> Task.async_stream(fn {result, nums} -> {eval(result, nums), result} end)
    |> Stream.map(fn {:ok, output} -> output end)
    |> Stream.filter(fn {eval, _result} -> eval end)
    |> Stream.map(fn {_eval, result} -> result end)
    |> Enum.sum()
  end

  def eval(result, numbers, acc \\ nil)
  def eval(result, [], acc), do: acc == result
  def eval(result, [number | tail], nil), do: eval(result, tail, number)
  def eval(result, _numbers, acc) when acc > result, do: false

  def eval(result, [number | tail], acc) do
    eval(result, tail, acc + number) or
      eval(result, tail, acc * number) or
      eval(result, tail, concat(acc, number))
  end

  defp concat(a, b) when b < 10, do: a * 10 + b
  defp concat(a, b) when b < 100, do: a * 100 + b
  defp concat(a, b) when b < 1000, do: a * 1000 + b
end
