defmodule Advent.Y2019.Day05 do
  alias Advent.Y2019.Computer

  def run(puzzle, input) do
    puzzle
    |> Computer.parse_program()
    |> Computer.run_program(input)
  end

  def parse_program(program) do
    for {code, index} <- program |> String.split(",") |> Enum.with_index(),
        into: %{},
        do: {index, String.to_integer(code)}
  end
end
