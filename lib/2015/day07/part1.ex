defmodule Advent.Y2015.Day07.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, &apply_instruction(&1, &2))
    |> Map.get("a")
  end

  @regex Regex.compile!(~S/(?<instruction>.*) -> (?<wire>.*)/)
  def parse_line(line) do
    %{"instruction" => instruction, "wire" => wire} = Regex.named_captures(@regex, line)

    decoded_instruction =
      case Integer.parse(instruction) do
        {value, _} -> value
        :error -> instruction |> String.split(" ") |> List.to_tuple()
      end

    {decoded_instruction, wire}
  end

  def run_instructions(program) do
    Stream.cycle([0])
    |> Enum.reduce_while({program, %{}}, fn _, {program, wires} ->
      {program, wires} =
        Enum.reduce(program, {program, wires}, fn instruction, {program, wires} ->
          case apply_instruction(instruction, wires) do
            nil ->
              {program, wires}

            wires ->
              # remove current instruction from program
              {program, wires}
          end
        end)

      case {program, wires} do
        {[], wires} -> {:halt, wires}
        acc -> {:cont, acc}
      end
    end)
  end

  def apply_instruction({value, output_wire}, wires) when is_integer(value) do
    put_value(wires, output_wire, value)
  end

  def apply_instruction({{input_wire}, output_wire}, wires) when is_binary(input_wire) do
    case Map.get(wires, input_wire) do
      nil -> nil
      value -> put_value(wires, output_wire, value)
    end
  end

  def apply_instruction({{"NOT", wire}, output_wire}, wires) do
    case Map.get(wires, wire) do
      nil -> nil
      value -> put_value(wires, output_wire, Bitwise.bnot(value))
    end
  end

  def apply_instruction({{wire1, "AND", wire2}, output_wire}, wires) do
    case {Map.get(wires, wire1), Map.get(wires, wire2)} do
      {nil, _} -> nil
      {_, nil} -> nil
      {value1, value2} -> put_value(wires, output_wire, Bitwise.band(value1, value2))
    end
  end

  def apply_instruction({{wire1, "OR", wire2}, output_wire}, wires) do
    case {Map.get(wires, wire1), Map.get(wires, wire2)} do
      {nil, _} -> nil
      {_, nil} -> nil
      {value1, value2} -> put_value(wires, output_wire, Bitwise.bor(value1, value2))
    end
  end

  def apply_instruction({{wire, "LSHIFT", value}, output_wire}, wires) do
    value2 = String.to_integer(value)

    case Map.get(wires, wire) do
      nil -> nil
      value1 -> put_value(wires, output_wire, Bitwise.bsl(value1, value2))
    end
  end

  def apply_instruction({{wire, "RSHIFT", value}, output_wire}, wires) do
    value2 = String.to_integer(value)

    case Map.get(wires, wire) do
      nil -> nil
      value1 -> put_value(wires, output_wire, Bitwise.bsr(value1, value2))
    end
  end

  defp put_value(wires, wire, value) when value < 0 do
    Map.put(wires, wire, 65536 + value)
  end

  defp put_value(wires, wire, value) when value > 65535 do
    Map.put(wires, wire, value - 65536)
  end

  defp put_value(wires, wire, value) do
    Map.put(wires, wire, value)
  end
end
