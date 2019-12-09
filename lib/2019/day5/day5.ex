defmodule Advent.Y2019.Day5 do
  def run(puzzle, input) do
    puzzle |> String.split(",") |> run_program(input)
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day5
  iex> Day5.run_program(["1002","4","3","4","33"], ["0"])
  nil
  iex> program = String.split("3,9,8,9,10,9,4,9,99,-1,8", ",")
  iex> {Day5.run_program(program, ["8"]), Day5.run_program(program, ["3"]) }
  {1, 0}
  iex> program = String.split("3,9,7,9,10,9,4,9,99,-1,8", ",")
  iex> {Day5.run_program(program, ["3"]), Day5.run_program(program, ["10"])}
  {1, 0}
  iex> program = String.split("3,3,1108,-1,8,3,4,3,99", ",")
  iex> {Day5.run_program(program, ["8"]), Day5.run_program(program, ["3"])}
  {1, 0}
  iex> program = String.split("3,3,1107,-1,8,3,4,3,99", ",")
  iex> {Day5.run_program(program, ["3"]), Day5.run_program(program, ["10"])}
  {1, 0}
  iex> program = String.split("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", ",")
  iex> {Day5.run_program(program, ["10"]), Day5.run_program(program, ["0"])}
  {1, 0}
  """
  def run_program(program, inputs, pos \\ 0, output \\ nil) do
    case program |> Enum.slice(pos, 4) |> read_instruction(program, pos, inputs) do
      {program, new_pos, output, new_inputs} -> run_program(program, new_inputs, new_pos, output)
      :halt -> output
    end
  end

  def read_instruction([instruction | params], prog, pos, inputs) do
    instruction
    |> String.pad_leading(5, "0")
    |> run_instruction(Enum.map(params, &String.to_integer/1), pos, prog, inputs)
  end

  # Add instruction
  def run_instruction(<<_, p2_mode, p1_mode, "01">>, [p1, p2, p3], pos, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1)
    p2 = param(<<p2_mode>>, prog, p2)
    {List.replace_at(prog, p3, to_string(p1 + p2)), pos + 4, nil, inputs}
  end

  # Multiply instruction
  def run_instruction(<<_, p2_mode, p1_mode, "02">>, [p1, p2, p3], pos, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1)
    p2 = param(<<p2_mode>>, prog, p2)
    {List.replace_at(prog, p3, to_string(p1 * p2)), pos + 4, nil, inputs}
  end

  # Input instruction
  def run_instruction(<<_, _, _, "03">>, _params, _pos, _prog, []), do: :waiting_input

  def run_instruction(<<_, _, _, "03">>, [p1 | _], pos, prog, [input | inputs]) do
    {List.replace_at(prog, p1, to_string(input)), pos + 2, nil, inputs}
  end

  # Output instruction
  def run_instruction(<<_, _, p1_mode, "04">>, [p1 | _], pos, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1)
    {prog, pos + 2, p1, inputs}
  end

  # Test != 0
  def run_instruction(<<_, p2_mode, p1_mode, "05">>, [p1, p2 | _], pos, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1)
    p2 = param(<<p2_mode>>, prog, p2)
    if p1 != 0, do: {prog, p2, nil, inputs}, else: {prog, pos + 3, nil, inputs}
  end

  # Test == 0
  def run_instruction(<<_, p2_mode, p1_mode, "06">>, [p1, p2 | _], pos, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1)
    p2 = param(<<p2_mode>>, prog, p2)
    if p1 == 0, do: {prog, p2, nil, inputs}, else: {prog, pos + 3, nil, inputs}
  end

  # Test <
  def run_instruction(<<_, p2_mode, p1_mode, "07">>, [p1, p2, p3 | _], pos, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1)
    p2 = param(<<p2_mode>>, prog, p2)
    value = if p1 < p2, do: "1", else: "0"
    {List.replace_at(prog, p3, value), pos + 4, nil, inputs}
  end

  # Test ==
  def run_instruction(<<_, p2_mode, p1_mode, "08">>, [p1, p2, p3 | _], pos, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1)
    p2 = param(<<p2_mode>>, prog, p2)
    value = if p1 == p2, do: "1", else: "0"
    {List.replace_at(prog, p3, value), pos + 4, nil, inputs}
  end

  def run_instruction(<<_, _, _, "99">>, _, _, _, _), do: :halt

  @doc ~S"""
  iex> alias Advent.Y2019.Day5
  iex> Day5.param("0", ["1002","4","3","4","33"], 4)
  33
  iex> Day5.param("1", ["1002","4","3","4","33"], 4)
  4
  """
  def param("0", prog, position), do: prog |> Enum.at(position) |> String.to_integer()
  def param("1", _prog, value), do: value
end
