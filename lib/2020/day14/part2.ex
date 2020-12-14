defmodule Advent.Y2020.Day14.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.reduce({%{}, nil}, &run_instruction/2)
    |> Advent.Y2020.Day14.Part1.memory_sum()
  end

  def run_instruction(line = "mask" <> _, {memory, _mask}) do
    {memory, line |> String.split(" = ") |> Enum.at(-1)}
  end

  @regex Regex.compile!(~S/mem\[(?<address>\d+)\] = (?<value>\d+)/)
  def run_instruction(instruction, {memory, mask}) do
    %{"address" => address, "value" => value} = Regex.named_captures(@regex, instruction)
    {address, value} = {String.to_integer(address), String.to_integer(value)}

    memory =
      address
      |> find_addresses(mask)
      |> Enum.reduce(memory, fn address, memory ->
        Map.put(memory, address, value)
      end)

    {memory, mask}
  end

  def find_addresses(address, mask) do
    address
    |> Integer.to_string(2)
    |> String.pad_leading(String.length(mask), "0")
    |> String.graphemes()
    |> Enum.zip(String.graphemes(mask))
    |> find_addresses()
  end

  def find_addresses(address_and_mask) do
    Enum.reduce(address_and_mask, [0], fn
      {_, "X"}, acc -> fork(acc)
      {_, "1"}, acc -> add_bit(acc, 1)
      {"1", _}, acc -> add_bit(acc, 1)
      _, acc -> add_bit(acc, 0)
    end)
  end

  def add_bit(acc, bit), do: Enum.map(acc, &(&1 * 2 + bit))
  def fork(acc), do: Enum.flat_map(acc, &[&1 * 2, &1 * 2 + 1])
end
