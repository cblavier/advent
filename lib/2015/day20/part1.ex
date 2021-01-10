defmodule Advent.Y2015.Day20.Part1 do
  def run(puzzle) do
    puzzle = String.to_integer(puzzle) / 10

    1
    |> Stream.iterate(&(&1 + 1))
    |> Stream.map(&{&1, present_count(&1)})
    |> Stream.filter(&(elem(&1, 1) >= puzzle))
    |> Enum.at(0)
    |> elem(0)
  end

  def present_count(house_number) do
    house_number |> divisors() |> Enum.sum()
  end

  def divisors(n), do: divisors(n, 1, [])

  def divisors(n, i, factors) when n < i * i, do: factors
  def divisors(n, i, factors) when n == i * i, do: [i | factors]

  def divisors(n, i, factors) when rem(n, i) == 0,
    do: divisors(n, i + 1, [i, div(n, i) | factors])

  def divisors(n, i, factors) do
    divisors(n, i + 1, factors)
  end
end
