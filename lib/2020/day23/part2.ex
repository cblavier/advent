defmodule Advent.Y2020.Day23.Part2 do
  alias Advent.Y2020.Day23.Part1

  @max 1_000_000
  @steps 10_000_000

  def run(puzzle) do
    sequence = build_sequence(puzzle)
    circle = Part1.build_circle(sequence)

    [a, b, _] =
      1..@steps
      |> Enum.reduce({hd(sequence), circle}, fn _, {current, circle} ->
        Part1.move(circle, current, @max)
      end)
      |> elem(1)
      |> Part1.pick_up(1)

    a * b
  end

  def build_sequence(puzzle) do
    Part1.build_sequence(puzzle) ++ Enum.to_list(10..@max)
  end
end
