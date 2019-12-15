defmodule Advent.Y2019.Day15.Part2 do
  alias Advent.Y2019.Computer
  alias Advent.Y2019.Day15.Part1

  def run(puzzle) do
    puzzle
    |> Computer.parse_program()
    |> program_at_oxygen_sytem()
    |> fill_oxygen()
    |> Enum.max()
  end

  defp program_at_oxygen_sytem(program) do
    program
    |> Part1.find_oxygen_system()
    |> Enum.min_by(&elem(&1, 2))
  end

  defp fill_oxygen({prog, pos, _}, minutes \\ 0, last_direction \\ nil) do
    last_direction
    |> Part1.directions()
    |> Enum.flat_map(fn dir ->
      {:waiting_input, prog, pos, [output | _]} = Computer.run_program(prog, dir, pos)

      case output do
        0 -> [minutes]
        1 -> fill_oxygen({prog, pos, nil}, minutes + 1, dir)
      end
    end)
  end
end
