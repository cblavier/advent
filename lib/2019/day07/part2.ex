defmodule Advent.Y2019.Day07.Part2 do
  alias Advent.Y2019.Day05, as: Computer
  alias Advent.Y2019.Day07.Part1

  @doc ~S"""
  iex> alias Advent.Y2019.Day07.Part2
  iex> program = "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,"
  iex> program = program <> "27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"
  iex> Part2.run(program)
  139_629_729
  iex> program = "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,"
  iex> program = program <> "1005,55,26,1001,54,-5,54,1105,1,12,1,"
  iex> program = program <> "53,54,53,1008,54,0,55,1001,55,1,55,2,"
  iex> program = program <> "53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10"
  iex> Part2.run(program)
  18_216
  """
  def run(puzzle) do
    puzzle |> Computer.parse_program() |> max_thrust()
  end

  def max_thrust(program, input \\ 0) do
    for signals <- Part1.permutations([5, 6, 7, 8, 9]) do
      Task.async(fn ->
        run_amplifiers(program, signals, input)
      end)
    end
    |> Enum.map(&Task.await/1)
    |> Enum.max()
  end

  defp run_amplifiers(program, signals, input) do
    signals
    |> Enum.with_index()
    |> Enum.map(fn {signal, index} ->
      last = index == length(signals) - 1
      amplifier_process(program, signal, self(), last)
    end)
    |> connect_amplifiers()
    |> Enum.at(0)
    |> send({:input, input})

    receive do
      {:thrust, thrust} -> thrust
    end
  end

  defp amplifier_process(program, signal, parent_pid, last) do
    spawn(fn ->
      receive do
        {:connect, output_pid} ->
          thrust = run_program(program, [signal], output_pid)
          if last, do: send(parent_pid, {:thrust, thrust})
      end
    end)
  end

  defp connect_amplifiers(amplifiers) do
    for {amplifier, i} <- Enum.with_index(amplifiers) do
      output_index = rem(i + 1, length(amplifiers))
      output_amplifier = Enum.at(amplifiers, output_index)
      send(amplifier, {:connect, output_amplifier})
      amplifier
    end
  end

  defp run_program(program, inputs, output_pid, positions \\ {0, 0}, output \\ nil) do
    case read_next_instruction(program, positions, inputs) do
      :halt ->
        output

      :waiting_input ->
        receive do
          {:input, input} -> run_program(program, [input], output_pid, positions, output)
        end

      {program, positions, new_output, inputs} ->
        if new_output, do: send(output_pid, {:input, new_output})
        run_program(program, inputs, output_pid, positions, new_output || output)
    end
  end

  defp read_next_instruction(program, positions = {abs, _rel}, inputs) do
    program
    |> Map.take(abs..(abs + 3))
    |> Enum.sort()
    |> Enum.map(&elem(&1, 1))
    |> Computer.read_instruction(positions, program, inputs)
  end
end
