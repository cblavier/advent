defmodule Advent.Y2019.Day09 do
  alias Advent.Y2019.Computer

  def run(puzzle, input) do
    puzzle
    |> Computer.parse_program()
    |> Computer.run_program(input)
  end
end
