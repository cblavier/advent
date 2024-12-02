defmodule Advent.Y2017.Day18.Part2 do
  alias Advent.Y2017.Day18.Part1

  def run(puzzle) do
    program = Part1.parse(puzzle)

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while(
      {{0, %{"p" => 0}, []}, {0, %{"p" => 1}, []}, 0},
      fn _i, {{p0, regs0, sounds0}, {p1, regs1, sounds1}, count} ->
        {new_p0, regs0, new_sounds0, sent_sounds0} = exec(program, p0, regs0, sounds0)
        {new_p1, regs1, new_sounds1, sent_sounds1} = exec(program, p1, regs1, sounds1)

        if {new_p0, new_p1} == {p0, p1} do
          {:halt, count}
        else
          {:cont,
           {
             {new_p0, regs0, new_sounds0 ++ sent_sounds1},
             {new_p1, regs1, new_sounds1 ++ sent_sounds0},
             if(Enum.any?(sent_sounds1), do: count + 1, else: count)
           }}
        end
      end
    )
  end

  def exec(_program, nil, registers, sounds) do
    {nil, registers, sounds, []}
  end

  def exec(program, pos, registers, sounds) do
    case Enum.at(program, pos) do
      nil ->
        {nil, registers, sounds, []}

      %{type: :snd, register: r} ->
        if is_integer(r) do
          {pos + 1, registers, sounds, [r]}
        else
          {pos + 1, registers, sounds, [Map.get(registers, r, 0)]}
        end

      %{type: :rcv, register: r} ->
        case sounds do
          [] ->
            {pos, registers, sounds, []}

          [sound | tail] ->
            {pos + 1, Map.put(registers, r, sound), tail, []}
        end

      %{type: :set, register: r1, arg: r2} ->
        v = value(registers, r2)
        {pos + 1, Map.put(registers, r1, v), sounds, []}

      %{type: :add, register: r1, arg: r2} ->
        v1 = value(registers, r1)
        v2 = value(registers, r2)
        {pos + 1, Map.put(registers, r1, v1 + v2), sounds, []}

      %{type: :mul, register: r1, arg: r2} ->
        v1 = value(registers, r1)
        v2 = value(registers, r2)
        {pos + 1, Map.put(registers, r1, v1 * v2), sounds, []}

      %{type: :mod, register: r1, arg: r2} ->
        v1 = value(registers, r1)
        v2 = value(registers, r2)
        {pos + 1, Map.put(registers, r1, rem(v1, v2)), sounds, []}

      %{type: :jgz, register: r1, arg: r2} ->
        if value(registers, r1) > 0 do
          offset = value(registers, r2)
          {pos + offset, registers, sounds, []}
        else
          {pos + 1, registers, sounds, []}
        end
    end
  end

  defp value(_registers, val) when is_integer(val), do: val
  defp value(registers, reg), do: Map.get(registers, reg, 0)
end
