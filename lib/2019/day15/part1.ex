defmodule Advent.Y2019.Day15.Part1 do
  alias Advent.Y2019.Computer

  def run(puzzle) do
    puzzle
    |> Computer.parse_program()
    |> find_oxygen_system()
    |> Enum.min_by(&elem(&1, 2))
  end

  def find_oxygen_system(prog, pos \\ {0, 0}, path_length \\ 0, last_direction \\ nil) do
    last_direction
    |> directions()
    |> Enum.flat_map(fn dir ->
      {:waiting_input, prog, pos, [output | _]} = Computer.run_program(prog, dir, pos)

      case output do
        0 -> []
        1 -> find_oxygen_system(prog, pos, path_length + 1, dir)
        2 -> [{prog, pos, path_length + 1}]
      end
    end)
  end

  def directions(nil), do: [1, 2, 3, 4]
  def directions(1), do: [1, 3, 4]
  def directions(2), do: [2, 3, 4]
  def directions(3), do: [1, 2, 3]
  def directions(4), do: [1, 2, 4]
end
