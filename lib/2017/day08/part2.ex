defmodule Advent.Y2017.Day08.Part2 do
  alias Advent.Y2017.Day08.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&Part1.parse_instruction/1)
    |> Enum.reduce({%{}, 0}, &run_instruction/2)
    |> elem(1)
  end

  defp run_instruction(i, {registers, max}) do
    if Part1.eval_cond(i.cond_reg, i.cond_op, i.cond_v, registers) do
      value = Part1.value(i.reg, i.op, i.val, registers)
      {Map.put(registers, i.reg, value), max(max, value)}
    else
      {registers, max}
    end
  end
end
