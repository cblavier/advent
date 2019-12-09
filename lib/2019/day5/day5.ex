defmodule Advent.Y2019.Day5 do
  def run(puzzle, input) do
    puzzle |> String.split(",") |> run_program(input)
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day5
  iex> Day5.run_program(["1002","4","3","4","33"], ["0"])
  []
  iex> program = String.split("3,9,8,9,10,9,4,9,99,-1,8", ",")
  iex> {Day5.run_program(program, ["8"]), Day5.run_program(program, ["3"]) }
  {[1], [0]}
  iex> program = String.split("3,9,7,9,10,9,4,9,99,-1,8", ",")
  iex> {Day5.run_program(program, ["3"]), Day5.run_program(program, ["10"])}
  {[1], [0]}
  iex> program = String.split("3,3,1108,-1,8,3,4,3,99", ",")
  iex> {Day5.run_program(program, ["8"]), Day5.run_program(program, ["3"])}
  {[1], [0]}
  iex> program = String.split("3,3,1107,-1,8,3,4,3,99", ",")
  iex> {Day5.run_program(program, ["3"]), Day5.run_program(program, ["10"])}
  {[1], [0]}
  iex> program = String.split("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", ",")
  iex> {Day5.run_program(program, ["10"]), Day5.run_program(program, ["0"])}
  {[1], [0]}
  """
  def run_program(program, inputs, positions = {absolute, _rel} \\ {0, 0}, outputs \\ []) do
    case program |> Enum.slice(absolute, 4) |> read_instruction(program, positions, inputs) do
      {program, positions, nil, inputs} ->
        run_program(program, inputs, positions, outputs)

      {program, positions, output, inputs} ->
        run_program(program, inputs, positions, outputs ++ [output])

      :halt ->
        outputs
    end
  end

  def read_instruction([instruction | params], prog, positions, inputs) do
    instruction
    |> String.pad_leading(5, "0")
    |> run_instruction(Enum.map(params, &String.to_integer/1), positions, prog, inputs)
  end

  # Add instruction
  def run_instruction(<<p3_m, p2_m, p1_m, "01">>, [p1, p2, p3], {absolute, rel}, prog, inputs) do
    p1 = param(<<p1_m>>, prog, p1, rel)
    p2 = param(<<p2_m>>, prog, p2, rel)
    p3 = out_position(<<p3_m>>, p3, rel)
    {write_memory(prog, p3, to_string(p1 + p2)), {absolute + 4, rel}, nil, inputs}
  end

  # Multiply instruction
  def run_instruction(<<p3_m, p2_m, p1_m, "02">>, [p1, p2, p3], {absolute, rel}, prog, inputs) do
    p1 = param(<<p1_m>>, prog, p1, rel)
    p2 = param(<<p2_m>>, prog, p2, rel)
    p3 = out_position(<<p3_m>>, p3, rel)
    {write_memory(prog, p3, to_string(p1 * p2)), {absolute + 4, rel}, nil, inputs}
  end

  # Input instruction
  def run_instruction(<<_, _, _, "03">>, _params, _positions, _prog, []), do: :waiting_input

  def run_instruction(<<_, _, p1_m, "03">>, [p1 | _], {absolute, rel}, prog, [input | inputs]) do
    p1 = out_position(<<p1_m>>, p1, rel)
    {write_memory(prog, p1, to_string(input)), {absolute + 2, rel}, nil, inputs}
  end

  # Output instruction
  def run_instruction(<<_, _, p1_mode, "04">>, [p1 | _], {absolute, rel}, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1, rel)
    {prog, {absolute + 2, rel}, p1, inputs}
  end

  # Test != 0
  def run_instruction(<<_, p2_mode, p1_mode, "05">>, [p1, p2 | _], {absolute, rel}, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1, rel)
    p2 = param(<<p2_mode>>, prog, p2, rel)
    if p1 != 0, do: {prog, {p2, rel}, nil, inputs}, else: {prog, {absolute + 3, rel}, nil, inputs}
  end

  # Test == 0
  def run_instruction(<<_, p2_mode, p1_mode, "06">>, [p1, p2 | _], {absolute, rel}, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1, rel)
    p2 = param(<<p2_mode>>, prog, p2, rel)
    if p1 == 0, do: {prog, {p2, rel}, nil, inputs}, else: {prog, {absolute + 3, rel}, nil, inputs}
  end

  # Test <
  def run_instruction(<<p3_m, p2_m, p1_m, "07">>, [p1, p2, p3 | _], {abs, rel}, prog, inputs) do
    p1 = param(<<p1_m>>, prog, p1, rel)
    p2 = param(<<p2_m>>, prog, p2, rel)
    p3 = out_position(<<p3_m>>, p3, rel)
    value = if p1 < p2, do: "1", else: "0"
    {write_memory(prog, p3, value), {abs + 4, rel}, nil, inputs}
  end

  # Test ==
  def run_instruction(<<p3_m, p2_m, p1_m, "08">>, [p1, p2, p3 | _], {abs, rel}, prog, inputs) do
    p1 = param(<<p1_m>>, prog, p1, rel)
    p2 = param(<<p2_m>>, prog, p2, rel)
    p3 = out_position(<<p3_m>>, p3, rel)
    value = if p1 == p2, do: "1", else: "0"
    {write_memory(prog, p3, value), {abs + 4, rel}, nil, inputs}
  end

  # Change relative offset
  def run_instruction(<<_, _, p1_mode, "09">>, [p1 | _], {absolute, rel}, prog, inputs) do
    p1 = param(<<p1_mode>>, prog, p1, rel)
    {prog, {absolute + 2, rel + p1}, nil, inputs}
  end

  def run_instruction(<<_, _, _, "99">>, _, _, _, _), do: :halt

  # Position mode
  def param("0", prog, value, _relative) do
    prog |> Enum.at(value, "0") |> String.to_integer()
  end

  # Immediate mode
  def param("1", _prog, value, _relative), do: value

  # Relative mode
  def param("2", prog, value, relative) do
    prog |> Enum.at(value + relative, "0") |> String.to_integer()
  end

  def out_position("0", position, _relative), do: position
  def out_position("2", position, relative), do: position + relative

  def write_memory(program, position, value) when position > length(program) - 1 do
    program = program ++ List.duplicate("0", position + 1 - length(program))
    write_memory(program, position, value)
  end

  def write_memory(program, position, value) do
    List.replace_at(program, position, value)
  end
end
