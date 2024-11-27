defmodule Advent.Y2017.Day08.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
    |> Enum.reduce(%{}, &run_instruction/2)
    |> Map.values()
    |> Enum.max()
  end

  def parse_instruction(instruction) do
    [reg, op, val, "if", cond_reg, cond_op, cond_val] = String.split(instruction)

    %{
      reg: reg,
      op: op,
      val: String.to_integer(val),
      cond_reg: cond_reg,
      cond_op: cond_op,
      cond_v: String.to_integer(cond_val)
    }
  end

  defp run_instruction(i, registers) do
    if eval_cond(i.cond_reg, i.cond_op, i.cond_v, registers) do
      value = value(i.reg, i.op, i.val, registers)
      Map.put(registers, i.reg, value)
    else
      registers
    end
  end

  def value(reg, "inc", val, registers), do: Map.get(registers, reg, 0) + val
  def value(reg, "dec", val, registers), do: Map.get(registers, reg, 0) - val

  def eval_cond(reg, ">", v, regs), do: Map.get(regs, reg, 0) > v
  def eval_cond(reg, "<", v, regs), do: Map.get(regs, reg, 0) < v
  def eval_cond(reg, ">=", v, regs), do: Map.get(regs, reg, 0) >= v
  def eval_cond(reg, "<=", v, regs), do: Map.get(regs, reg, 0) <= v
  def eval_cond(reg, "==", v, regs), do: Map.get(regs, reg, 0) == v
  def eval_cond(reg, "!=", v, regs), do: Map.get(regs, reg, 0) != v
end
