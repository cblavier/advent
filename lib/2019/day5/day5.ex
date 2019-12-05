defmodule Advent.Y2019.Day5 do
  def run(path, input) do
    path |> File.read!() |> String.split(",") |> run_program(input)
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day5
  iex> Day5.run_program(["1002","4","3","4","33"], "0")
  nil
  iex> program = String.split("3,9,8,9,10,9,4,9,99,-1,8", ",")
  iex> {Day5.run_program(program, "8"), Day5.run_program(program, "3")}
  {1, 0}
  iex> program = String.split("3,9,7,9,10,9,4,9,99,-1,8", ",")
  iex> {Day5.run_program(program, "3"), Day5.run_program(program, "10")}
  {1, 0}
  iex> program = String.split("3,3,1108,-1,8,3,4,3,99", ",")
  iex> {Day5.run_program(program, "8"), Day5.run_program(program, "3")}
  {1, 0}
  iex> program = String.split("3,3,1107,-1,8,3,4,3,99", ",")
  iex> {Day5.run_program(program, "3"), Day5.run_program(program, "10")}
  {1, 0}
  iex> program = String.split("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", ",")
  iex> {Day5.run_program(program, "10"), Day5.run_program(program, "0")}
  {1, 0}
  """
  def run_program(program, input, pos \\ 0, output \\ nil) do
    case program |> Enum.slice(pos, 4) |> read_instruction(program, pos, input) do
      {program, new_pos, output} -> run_program(program, input, new_pos, output)
      :halt -> output
    end
  end

  def read_instruction([instruction | params], prog, pos, input) do
    params = Enum.map(params, &String.to_integer/1)

    case {String.pad_leading(instruction, 5, "0"), params} do
      {<<_, p2_mode, p1_mode, "01">>, [p1, p2, p3]} ->
        p1 = param(<<p1_mode>>, prog, p1)
        p2 = param(<<p2_mode>>, prog, p2)
        new_pos = if p3 == pos, do: pos, else: pos + 4
        {List.replace_at(prog, p3, to_string(p1 + p2)), new_pos, nil}

      {<<_, p2_mode, p1_mode, "02">>, [p1, p2, p3]} ->
        p1 = param(<<p1_mode>>, prog, p1)
        p2 = param(<<p2_mode>>, prog, p2)
        new_pos = if p3 == pos, do: pos, else: pos + 4
        {List.replace_at(prog, p3, to_string(p1 * p2)), new_pos, nil}

      {<<_, _, _, "03">>, [p1 | _]} ->
        new_pos = if p1 == pos, do: pos, else: pos + 2
        {List.replace_at(prog, p1, input), new_pos, nil}

      {<<_, _, p1_mode, "04">>, [p1 | _]} ->
        p1 = param(<<p1_mode>>, prog, p1)
        {prog, pos + 2, p1}

      {<<_, p2_mode, p1_mode, "05">>, [p1, p2 | _]} ->
        p1 = param(<<p1_mode>>, prog, p1)
        p2 = param(<<p2_mode>>, prog, p2)
        if p1 != 0, do: {prog, p2, nil}, else: {prog, pos + 3, nil}

      {<<_, p2_mode, p1_mode, "06">>, [p1, p2 | _]} ->
        p1 = param(<<p1_mode>>, prog, p1)
        p2 = param(<<p2_mode>>, prog, p2)
        if p1 == 0, do: {prog, p2, nil}, else: {prog, pos + 3, nil}

      {<<_, p2_mode, p1_mode, "07">>, [p1, p2, p3 | _]} ->
        p1 = param(<<p1_mode>>, prog, p1)
        p2 = param(<<p2_mode>>, prog, p2)
        value = if p1 < p2, do: "1", else: "0"
        new_pos = if p3 == pos, do: pos, else: pos + 4
        {List.replace_at(prog, p3, value), new_pos, nil}

      {<<_, p2_mode, p1_mode, "08">>, [p1, p2, p3 | _]} ->
        p1 = param(<<p1_mode>>, prog, p1)
        p2 = param(<<p2_mode>>, prog, p2)
        value = if p1 == p2, do: "1", else: "0"
        new_pos = if p3 == pos, do: pos, else: pos + 4
        {List.replace_at(prog, p3, value), new_pos, nil}

      {<<_, _, _, "99">>, _} ->
        :halt
    end
  end

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
