defmodule Advent.Y2015.Day16.Part2 do
  alias Advent.Y2015.Day16.Part1

  @tape Part1.tape()

  def run(puzzle) do
    puzzle
    |> Part1.parse()
    |> Stream.filter(&match_with_tape?(&1, @tape))
    |> Enum.at(0)
    |> elem(0)
  end

  def match_with_tape?({_, compounds}, tape) do
    compounds
    |> Map.keys()
    |> Enum.all?(fn
      k when k in ~w(cats trees)a -> compounds[k] > tape[k]
      k when k in ~w(pomeranians goldfish)a -> compounds[k] < tape[k]
      k -> compounds[k] == tape[k]
    end)
  end
end
