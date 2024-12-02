defmodule Advent.Y2017.Day18.Part1 do
  def run(puzzle) do
    puzzle
    |> parse()
    |> execute()
  end

  def parse(program) do
    program
    |> String.split("\n")
    |> Enum.map(fn
      <<op::binary-size(3)>> <> " " <> <<register::binary-size(1)>> <> " " <> arg ->
        %{type: String.to_atom(op), register: maybe_int(register), arg: maybe_int(arg)}

      <<op::binary-size(3)>> <> " " <> register ->
        %{type: String.to_atom(op), register: maybe_int(register)}
    end)
  end

  defp maybe_int(s) do
    case Integer.parse(s) do
      :error -> s
      {int, _} -> int
    end
  end

  def execute(program) do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({0, %{}, nil}, fn _i, {pos, registers, sound} ->
      case Enum.at(program, pos) do
        nil ->
          {:halt, nil}

        %{type: :snd, register: r} ->
          {:cont, {pos + 1, registers, Map.get(registers, r, 0)}}

        %{type: :rcv, register: r} ->
          case Map.get(registers, r, 0) do
            0 -> {:cont, {pos + 1, registers, sound}}
            _ -> {:halt, sound}
          end

        %{type: :set, register: r1, arg: r2} ->
          v = value(registers, r2)
          {:cont, {pos + 1, Map.put(registers, r1, v), sound}}

        %{type: :add, register: r1, arg: r2} ->
          v1 = value(registers, r1)
          v2 = value(registers, r2)
          {:cont, {pos + 1, Map.put(registers, r1, v1 + v2), sound}}

        %{type: :mul, register: r1, arg: r2} ->
          v1 = value(registers, r1)
          v2 = value(registers, r2)
          {:cont, {pos + 1, Map.put(registers, r1, v1 * v2), sound}}

        %{type: :mod, register: r1, arg: r2} ->
          v1 = value(registers, r1)
          v2 = value(registers, r2)
          {:cont, {pos + 1, Map.put(registers, r1, rem(v1, v2)), sound}}

        %{type: :jgz, register: r1, arg: r2} ->
          if value(registers, r1) > 0 do
            offset = value(registers, r2)
            {:cont, {pos + offset, registers, sound}}
          else
            {:cont, {pos + 1, registers, sound}}
          end
      end
    end)
  end

  defp value(_registers, val) when is_integer(val), do: val
  defp value(registers, reg), do: Map.get(registers, reg, 0)
end
