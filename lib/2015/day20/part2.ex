defmodule Advent.Y2015.Day20.Part2 do
  alias Advent.Y2015.Day20.Part1

  def run(puzzle) do
    puzzle = String.to_integer(puzzle) / 11

    1
    |> Stream.iterate(&(&1 + 1))
    |> Stream.map(&{&1, present_count(&1)})
    |> Stream.filter(&(elem(&1, 1) >= puzzle))
    |> Enum.at(0)
    |> elem(0)
  end

  def present_count(house_number) do
    house_number
    |> Part1.divisors()
    |> Enum.reject(&(&1 * 50 <= house_number))
    |> Enum.sum()
  end
end
