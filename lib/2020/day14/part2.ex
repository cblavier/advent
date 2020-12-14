defmodule Advent.Y2020.Day14.Part2 do
  alias Advent.Y2020.Day14.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.reduce({%{}, nil}, &run_instruction/2)
    |> Part1.memory_sum()
  end

  def run_instruction(line = "mask" <> _, {memory, _mask}) do
    {memory, line |> String.split(" = ") |> Enum.at(-1) |> String.graphemes()}
  end

  @regex Regex.compile!(~S/mem\[(?<address>\d+)\] = (?<value>\d+)/)
  def run_instruction(instruction, {memory, mask}) do
    %{"address" => address, "value" => value} = Regex.named_captures(@regex, instruction)

    address =
      address
      |> String.to_integer()
      |> Integer.to_string(2)
      |> String.pad_leading(length(mask), "0")
      |> String.graphemes()

    memory =
      address
      |> find_addresses(mask)
      |> Enum.reduce(memory, fn address, memory ->
        Map.put(memory, address, String.to_integer(value))
      end)

    {memory, mask}
  end

  def find_addresses(address, mask), do: address |> Enum.zip(mask) |> find_addresses()

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
