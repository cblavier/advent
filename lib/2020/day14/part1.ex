defmodule Advent.Y2020.Day14.Part1 do
  import Bitwise

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.reduce({%{}, nil}, &run_instruction/2)
    |> memory_sum()
  end

  def run_instruction(line = "mask" <> _, {memory, _mask}) do
    mask = line |> String.split(" = ") |> Enum.at(-1)
    {or_mask, _} = mask |> String.replace("X", "0") |> Integer.parse(2)
    {and_mask, _} = mask |> String.replace("X", "1") |> Integer.parse(2)
    {memory, {or_mask, and_mask}}
  end

  @regex Regex.compile!(~S/mem\[(?<address>\d+)\] = (?<value>\d+)/)
  def run_instruction(instruction, {memory, masks = {or_mask, and_mask}}) do
    %{"address" => address, "value" => value} = Regex.named_captures(@regex, instruction)
    {address, value} = {String.to_integer(address), String.to_integer(value)}
    {Map.put(memory, address, (value ||| or_mask) &&& and_mask), masks}
  end

  def memory_sum({memory, _mask}) do
    memory |> Enum.map(&elem(&1, 1)) |> Enum.sum()
  end
end
