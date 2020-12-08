defmodule Advent.Y2020.Day08.Part1 do
  def run(puzzle) do
    puzzle
    |> parse_program()
    |> run_program()
    |> elem(0)
  end

  def parse_program(program) do
    program
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.map(fn {instruction, index} ->
      [inst_name, count] = String.split(instruction, " ")
      {index, {inst_name, String.to_integer(count)}}
    end)
    |> Map.new()
  end

  def run_program(program) do
    Stream.cycle([0])
    |> Enum.reduce_while({0, 0, MapSet.new()}, fn _, {position, acc, visited} ->
      if MapSet.member?(visited, position) do
        {:halt, {acc, :cycle, visited}}
      else
        case Map.get(program, position) do
          nil ->
            {:halt, {acc, :end, visited}}

          instruction ->
            {new_position, new_acc} = run_instruction(instruction, position, acc)
            {:cont, {new_position, new_acc, MapSet.put(visited, position)}}
        end
      end
    end)
  end

  def run_instruction({"nop", _}, position, acc), do: {position + 1, acc}
  def run_instruction({"acc", count}, position, acc), do: {position + 1, acc + count}
  def run_instruction({"jmp", count}, position, acc), do: {position + count, acc}
end
