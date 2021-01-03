defmodule Advent.Y2015.Day07.Part2 do
  alias Advent.Y2015.Day07.Part1

  def run(puzzle) do
    program = Part1.parse_program(puzzle)
    a = program |> Part1.run_program() |> Map.get("a")
    program |> Part1.run_program(%{"b" => a}) |> Map.get("a")
  end
end
