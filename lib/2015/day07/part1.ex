defmodule Advent.Y2015.Day07.Part1 do
  use Bitwise

  def run(puzzle) do
    puzzle
    |> parse_program()
    |> run_program()
    |> Map.get("a")
  end

  def parse_program(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  def parse_line(line) do
    %{"instruction" => instruction, "wire" => wire} = Regex.named_captures(~r/(?<instruction>.*) -> (?<wire>.*)/, line)

    {
      case String.split(instruction) do
        [value] -> maybe_integer(value)
        [unary, v] -> {operator(unary), maybe_integer(v)}
        [v1, binary, v2] -> {operator(binary), maybe_integer(v1), maybe_integer(v2)}
      end,
      wire
    }
  end

  def operator(op), do: op |> String.downcase() |> String.to_atom()

  def maybe_integer(s) do
    case Integer.parse(s) do
      {value, _} -> value
      :error -> s
    end
  end

  def run_program(program, wires \\ %{})
  def run_program([], wires), do: wires

  def run_program(program, wires) do
    can_be_run = Enum.group_by(program, &can_run_instruction?/1)
    wires = Enum.reduce(can_be_run.true, wires, &run_instruction/2)
    program = for instruction <- Map.get(can_be_run, :false, []) do
      replace_wires(instruction, wires)
    end
    run_program(program, wires)
  end

  def replace_wires({val, output}, wires) when is_binary(val), do: {Map.get(wires, val, val), output}
  def replace_wires({{op, val}, output}, wires), do: {{op, Map.get(wires, val, val)}, output}
  def replace_wires({{op, val1, val2}, output}, wires), do: {{op, Map.get(wires, val1, val1), Map.get(wires, val2, val2)}, output}

  def can_run_instruction?({val, _}) when is_integer(val), do: true
  def can_run_instruction?({{_op, val}, _}) when is_integer(val), do: true
  def can_run_instruction?({{_op, val1, val2}, _}) when is_integer(val1) and is_integer(val2), do: true
  def can_run_instruction?(_), do: false

  def run_instruction({val, wire}, wires) when is_integer(val), do: Map.put_new(wires, wire, val)
  def run_instruction({{:not, val}, wire}, wires), do: Map.put_new(wires, wire, ~~~val)
  def run_instruction({{:or, val1, val2}, wire}, wires), do: Map.put_new(wires, wire, val1 ||| val2)
  def run_instruction({{:and, val1, val2}, wire}, wires), do: Map.put_new(wires, wire, val1 &&& val2)
  def run_instruction({{:lshift, val1, val2}, wire}, wires), do: Map.put_new(wires, wire, val1 <<< val2)
  def run_instruction({{:rshift, val1, val2}, wire}, wires), do: Map.put_new(wires, wire, val1 >>> val2)

end
