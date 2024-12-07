defmodule Advent.Y2024.Day07.Part1 do
  def run(puzzle) do
    puzzle
    |> parse()
    |> Enum.filter(fn {result, nums} -> eval(result, nums) end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def parse(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn equation ->
      [result, numbers] = String.split(equation, ": ")
      numbers = numbers |> String.split(" ") |> Enum.map(&String.to_integer/1)
      {String.to_integer(result), numbers}
    end)
  end

  def eval(result, numbers, total \\ nil)
  def eval(result, [], total), do: total == result
  def eval(result, [number | tail], nil), do: eval(result, tail, number)
  def eval(result, _numbers, total) when total > result, do: false

  def eval(result, [number | tail], total) do
    eval(result, tail, total + number) or eval(result, tail, total * number)
  end
end
