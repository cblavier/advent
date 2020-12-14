defmodule Advent.Y2020.Day14.Part1 do
  use Bitwise

  def run(puzzle) do
    puzzle
    |> parse_program()
    |> Enum.map(&parse_program_chunk/1)
    |> Enum.reduce(%{}, &run_program_chunk/2)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def parse_program(program) do
    program
    |> String.split("\n")
    |> Enum.chunk_while(
      [],
      fn
        item, [] -> {:cont, [item]}
        item = "mask" <> _, acc -> {:cont, Enum.reverse(acc), [item]}
        item, acc -> {:cont, [item | acc]}
      end,
      fn
        [] -> {:cont, []}
        acc -> {:cont, Enum.reverse(acc), []}
      end
    )
  end

  @regex Regex.compile!(~S/mem\[(?<address>\d+)\] = (?<value>\d+)/)
  def parse_program_chunk([mask | instructions]) do
    mask = mask |> String.split(" = ") |> Enum.at(-1)

    instructions =
      Enum.map(instructions, fn instruction ->
        %{"address" => address, "value" => value} = Regex.named_captures(@regex, instruction)
        {String.to_integer(address), String.to_integer(value)}
      end)

    {mask, instructions}
  end

  def run_program_chunk({mask, instructions}, memory) do
    {or_mask, _} = mask |> String.replace("X", "0") |> Integer.parse(2)
    {and_mask, _} = mask |> String.replace("X", "1") |> Integer.parse(2)

    Enum.reduce(instructions, memory, fn {address, value}, memory ->
      Map.put(memory, address, (value ||| or_mask) &&& and_mask)
    end)
  end
end
