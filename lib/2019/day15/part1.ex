defmodule Advent.Y2019.Day15.Part1 do
  alias Advent.Y2019.Computer

  def run(puzzle) do
    puzzle
    |> Computer.parse_program()
    |> command_robot()
    |> Enum.min_by(&elem(&1, 2))
  end

  def command_robot(program, pos \\ {0, 0}, path_length \\ 0, last_direction \\ nil) do
    last_direction
    |> directions()
    |> Enum.map(fn direction ->
      {:waiting_input, program, pos, [output | _]} = Computer.run_program(program, direction, pos)

      case output do
        0 -> []
        1 -> command_robot(program, pos, path_length + 1, direction)
        2 -> [{program, pos, path_length + 1}]
      end
    end)
    |> Enum.flat_map(& &1)
  end

  def directions(last_direction)
  def directions(nil), do: [1, 2, 3, 4]
  def directions(1), do: [1, 3, 4]
  def directions(2), do: [2, 3, 4]
  def directions(3), do: [1, 2, 3]
  def directions(4), do: [1, 2, 4]
end
