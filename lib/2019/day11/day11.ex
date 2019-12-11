defmodule Advent.Y2019.Day11 do
  alias Advent.Y2019.Computer

  def run(puzzle, initial_color) do
    program = Computer.parse_program(puzzle)
    robot = spawn_robot(program, initial_color)

    hull =
      [:color, :direction]
      |> Stream.cycle()
      |> Enum.reduce_while({%{}, {0, 0}, :up}, fn instruction, {hull, position, direction} ->
        receive do
          {:input, input} ->
            case instruction do
              :color ->
                {:cont, {Map.put(hull, position, input), position, direction}}

              :direction ->
                {new_position, new_direction} = direction(position, direction, input)
                send(robot, {:input, Map.get(hull, new_position, 0)})
                {:cont, {hull, new_position, new_direction}}
            end

          :halt ->
            {:halt, hull}
        end
      end)

    {hull, hull |> Map.keys() |> length()}
  end

  defp spawn_robot(program, input) do
    pid = self()

    spawn(fn ->
      Computer.run_program(program, [input], pid)
      send(pid, :halt)
    end)
  end

  defp direction({x, y}, :up, 0), do: {{x - 1, y}, :left}
  defp direction({x, y}, :up, 1), do: {{x + 1, y}, :right}
  defp direction({x, y}, :right, 0), do: {{x, y - 1}, :up}
  defp direction({x, y}, :right, 1), do: {{x, y + 1}, :down}
  defp direction({x, y}, :down, 0), do: {{x + 1, y}, :right}
  defp direction({x, y}, :down, 1), do: {{x - 1, y}, :left}
  defp direction({x, y}, :left, 0), do: {{x, y + 1}, :down}
  defp direction({x, y}, :left, 1), do: {{x, y - 1}, :up}
end
