defmodule Advent.Y2020.Day14.Part2 do
  alias Advent.Y2020.Day14.Part1

  use Bitwise

  def run(puzzle) do
    puzzle
    |> Part1.parse_program()
    |> Enum.map(&Part1.parse_program_chunk/1)
    |> Enum.reduce(%{}, &run_program_chunk/2)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def run_program_chunk({mask, instructions}, memory) do
    Enum.reduce(instructions, memory, fn {address, value}, memory ->
      address
      |> find_addresses(mask)
      |> Enum.reduce(memory, fn address, memory ->
        Map.put(memory, address, value)
      end)
    end)
  end

  def find_addresses(address, mask) when is_integer(address) and is_binary(mask) do
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
