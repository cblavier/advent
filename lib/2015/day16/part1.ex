defmodule Advent.Y2015.Day16.Part1 do
  @tape %{
    children: 3,
    cats: 7,
    samoyeds: 2,
    pomeranians: 3,
    akitas: 0,
    vizslas: 0,
    goldfish: 5,
    trees: 3,
    cars: 2,
    perfumes: 1
  }

  def run(puzzle) do
    puzzle
    |> parse()
    |> Stream.filter(&match_with_tape?(&1, @tape))
    |> Enum.at(0)
    |> elem(0)
  end

  def parse(puzzle) do
    for line <- String.split(puzzle, "\n"), into: %{} do
      [sue, tail] = String.split(line, ": ", parts: 2)

      {sue,
       for compound <- String.split(tail, ", "), into: %{} do
         [name, quantity] = String.split(compound, ": ")
         {String.to_atom(name), String.to_integer(quantity)}
       end}
    end
  end

  def tape, do: @tape

  def match_with_tape?({_, compounds}, tape) do
    keys = Map.keys(compounds)
    Map.take(tape, keys) == compounds
  end
end
