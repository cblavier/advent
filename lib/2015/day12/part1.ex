defmodule Advent.Y2015.Day12.Part1 do
  def run(puzzle) do
    puzzle
    |> find_numbers()
    |> Enum.sum()
  end

  def find_numbers(puzzle) do
    ~r/-?[\d]+/
    |> Regex.scan(puzzle)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end
end
