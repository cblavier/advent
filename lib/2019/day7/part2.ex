defmodule Advent.Y2019.Day7.Part2 do
  alias Advent.Y2019.Day5, as: Computer
  alias Advent.Y2019.Day7.Part1

  def run(path) do
    path |> File.read!() |> String.split(",") |> compute()
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day7.Part2
  iex> program = ~w(3 26 1001 26 -4 26 3 27 1002 27 2 27 1 27 26)
  iex> program = program ++ ~w(27 4 27 1001 28 -1 28 1005 28 6 99 0 0 5)
  iex> Part2.compute(program)
  139_629_729
  iex> program = ~w(3 52 1001 52 -5 52 3 53 1 52 56 54 1007 54 5 55)
  iex> program = program ++ ~w(1005 55 26 1001 54 -5 54 1105 1 12 1)
  iex> program = program ++ ~w(53 54 53 1008 54 0 55 1001 55 1 55 2)
  iex> program = program ++ ~w(53 55 53 4 53 1001 56 -1 56 1005 56 6 99 0 0 0 0 10)
  iex> Part2.compute(program)
  18_216
  """
  def compute(program, input \\ 0) do
    for signals <- Part1.permutations(~w(5 6 7 8 9)) do
      Task.async(fn ->
        run_amplifiers(program, signals, input)
      end)
    end
    |> Enum.map(&Task.await/1)
    |> Enum.max()
  end

  def run_amplifiers(program, signals, input) do
    signals
    |> Enum.map(&amplifier_process(program, &1, self()))
    |> connect_amplifiers()
    |> Enum.at(0)
    |> send({:input, input})

    receive do
      {:output, output} -> output
    end
  end

  def amplifier_process(program, signal, parent_pid) do
    spawn(fn ->
      receive do
        {:connect, output_pid} ->
          output = run_program(program, [signal], output_pid)
          send(parent_pid, {:output, output})
      end
    end)
  end

  def connect_amplifiers(amplifiers) do
    for {amplifier, i} <- Enum.with_index(amplifiers) do
      output_index = rem(i + 1, length(amplifiers))
      output_amplifier = Enum.at(amplifiers, output_index)
      send(amplifier, {:connect, output_amplifier})
      amplifier
    end
  end

  def run_program(program, inputs, output_pid, pos \\ 0, output \\ nil) do
    case program |> Enum.slice(pos, 4) |> Computer.read_instruction(program, pos, inputs) do
      :halt ->
        receive do
          {:input, input} -> input
        end

      :waiting_input ->
        receive do
          {:input, input} -> run_program(program, [input], output_pid, pos, output)
        end

      {program, new_pos, nil, new_inputs} ->
        run_program(program, new_inputs, output_pid, new_pos, nil)

      {program, new_pos, output, new_inputs} ->
        send(output_pid, {:input, output})
        run_program(program, new_inputs, output_pid, new_pos, output)
    end
  end
end
