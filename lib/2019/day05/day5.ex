defmodule Advent.Y2019.Day05 do
  def run(puzzle, input) do
    puzzle |> parse_program() |> run_program(input)
  end

  def parse_program(program) do
    for {code, index} <- program |> String.split(",") |> Enum.with_index(),
        into: %{},
        do: {index, String.to_integer(code)}
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day05
  iex> program = Day05.parse_program("3,9,8,9,10,9,4,9,99,-1,8")
  iex> {Day05.run_program(program, [8]), Day05.run_program(program, [3]) }
  {[1], [0]}
  # iex> program = Day05.parse_program("3,9,7,9,10,9,4,9,99,-1,8")
  # iex> {Day05.run_program(program, [3]), Day05.run_program(program, [10])}
  # {[1], [0]}
  # iex> program = Day05.parse_program("3,3,1108,-1,8,3,4,3,99")
  # iex> {Day05.run_program(program, [8]), Day05.run_program(program, [3])}
  # {[1], [0]}
  # iex> program = Day05.parse_program("3,3,1107,-1,8,3,4,3,99")
  # iex> {Day05.run_program(program, [3]), Day05.run_program(program, [10])}
  # {[1], [0]}
  # iex> program = Day05.parse_program("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
  # iex> {Day05.run_program(program, [10]), Day05.run_program(program, [0])}
  # {[1], [0]}
  """
  def run_program(program, inputs, positions = {abs, _rel} \\ {0, 0}, outputs \\ []) do
    instruction = program |> Map.take(abs..(abs + 3)) |> Enum.sort() |> Enum.map(&elem(&1, 1))

    case read_instruction(instruction, positions, program, inputs) do
      {program, positions, nil, inputs} ->
        run_program(program, inputs, positions, outputs)

      {program, positions, output, inputs} ->
        run_program(program, inputs, positions, outputs ++ [output])

      :halt ->
        outputs
    end
  end

  # Add instruction
  def read_instruction([inst, p1, p2, p3], {abs, rel}, prog, inputs) when rem(inst, 100) == 1 do
    {p1_mode, p2_mode, p3_mode} = modes(inst)
    p1 = param(p1_mode, prog, p1, rel)
    p2 = param(p2_mode, prog, p2, rel)
    p3 = out_position(p3_mode, p3, rel)
    {write_memory(prog, p3, p1 + p2), {abs + 4, rel}, nil, inputs}
  end

  # Multiply instruction
  def read_instruction([inst, p1, p2, p3], {abs, rel}, prog, inputs) when rem(inst, 100) == 2 do
    {p1_mode, p2_mode, p3_mode} = modes(inst)
    p1 = param(p1_mode, prog, p1, rel)
    p2 = param(p2_mode, prog, p2, rel)
    p3 = out_position(p3_mode, p3, rel)
    {write_memory(prog, p3, p1 * p2), {abs + 4, rel}, nil, inputs}
  end

  # Input instruction
  def read_instruction([inst | _], _positions, _prog, []) when rem(inst, 1000) == 3,
    do: :waiting_input

  def read_instruction([inst, p1 | _], {abs, rel}, prog, [input | inputs])
      when rem(inst, 100) == 3 do
    {p1_mode, _, _} = modes(inst)
    p1 = out_position(p1_mode, p1, rel)
    {write_memory(prog, p1, input), {abs + 2, rel}, nil, inputs}
  end

  # Output instruction
  def read_instruction([inst, p1 | _], {abs, rel}, prog, inputs) when rem(inst, 100) == 4 do
    {p1_mode, _, _} = modes(inst)
    p1 = param(p1_mode, prog, p1, rel)
    {prog, {abs + 2, rel}, p1, inputs}
  end

  # Test != 0
  def read_instruction([inst, p1, p2 | _], {abs, rel}, prog, inputs) when rem(inst, 100) == 5 do
    {p1_mode, p2_mode, _} = modes(inst)
    p1 = param(p1_mode, prog, p1, rel)
    p2 = param(p2_mode, prog, p2, rel)
    if p1 != 0, do: {prog, {p2, rel}, nil, inputs}, else: {prog, {abs + 3, rel}, nil, inputs}
  end

  # Test == 0
  def read_instruction([inst, p1, p2 | _], {abs, rel}, prog, inputs) when rem(inst, 100) == 6 do
    {p1_mode, p2_mode, _} = modes(inst)
    p1 = param(p1_mode, prog, p1, rel)
    p2 = param(p2_mode, prog, p2, rel)
    if p1 == 0, do: {prog, {p2, rel}, nil, inputs}, else: {prog, {abs + 3, rel}, nil, inputs}
  end

  # Test <
  def read_instruction([inst, p1, p2, p3], {abs, rel}, prog, inputs) when rem(inst, 100) == 7 do
    {p1_mode, p2_mode, p3_mode} = modes(inst)
    p1 = param(p1_mode, prog, p1, rel)
    p2 = param(p2_mode, prog, p2, rel)
    p3 = out_position(p3_mode, p3, rel)
    value = if p1 < p2, do: 1, else: 0
    {write_memory(prog, p3, value), {abs + 4, rel}, nil, inputs}
  end

  # Test ==
  def read_instruction([inst, p1, p2, p3], {abs, rel}, prog, inputs) when rem(inst, 100) == 8 do
    {p1_mode, p2_mode, p3_mode} = modes(inst)
    p1 = param(p1_mode, prog, p1, rel)
    p2 = param(p2_mode, prog, p2, rel)
    p3 = out_position(p3_mode, p3, rel)
    value = if p1 == p2, do: 1, else: 0
    {write_memory(prog, p3, value), {abs + 4, rel}, nil, inputs}
  end

  # Change relative offset
  def read_instruction([inst, p1 | _], {abs, rel}, prog, inputs) when rem(inst, 100) == 9 do
    {p1_mode, _, _} = modes(inst)
    p1 = param(p1_mode, prog, p1, rel)
    {prog, {abs + 2, rel + p1}, nil, inputs}
  end

  def read_instruction([inst | _], _, _, _) when rem(inst, 100) == 99, do: :halt

  def modes(instruction) do
    {
      rem(div(instruction, 100), 10),
      rem(div(instruction, 1_000), 10),
      rem(div(instruction, 10_000), 10)
    }
  end

  def param(_position = 0, prog, value, _relative), do: Map.get(prog, value, 0)
  def param(_immediate = 1, _prog, value, _relative), do: value
  def param(_relative = 2, prog, value, relative), do: Map.get(prog, value + relative, 0)

  def out_position(0, position, _relative), do: position
  def out_position(2, position, relative), do: position + relative

  def write_memory(program, position, value) do
    Map.put(program, position, value)
  end
end
