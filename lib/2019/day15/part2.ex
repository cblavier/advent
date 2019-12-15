defmodule Advent.Y2019.Day15.Part2 do
  alias Advent.Y2019.Computer
  alias Advent.Y2019.Day15.Part1

  def run(puzzle) do
    {program, positions, _} =
      puzzle
      |> Computer.parse_program()
      |> Part1.command_robot()
      |> Enum.min_by(&elem(&1, 2))

    program
    |> fill_oxygen(positions)
    |> Enum.max()
  end

  def fill_oxygen(program, pos, minutes \\ 0, last_direction \\ nil) do
    last_direction
    |> Part1.directions()
    |> Enum.map(fn direction ->
      {:waiting_input, program, pos, [output | _]} = Computer.run_program(program, direction, pos)

      case output do
        0 -> [minutes]
        1 -> fill_oxygen(program, pos, minutes + 1, direction)
      end
    end)
    |> Enum.flat_map(& &1)
  end
end
