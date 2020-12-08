defmodule Advent.Y2020.Day08.Part1 do
  def run(puzzle) do
    puzzle
    |> parse_program()
    |> run_program()
    |> elem(0)
  end

  @regex Regex.compile!(~S/(?<inst_name>\w{3}) (?<count>[-+]\d+)/)
  def parse_program(program) do
    program
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.map(fn {instruction, index} ->
      %{"inst_name" => inst_name, "count" => count} = Regex.named_captures(@regex, instruction)
      {index, {inst_name, String.to_integer(count)}}
    end)
    |> Map.new()
  end

  def run_program(program) do
    Stream.cycle([0])
    |> Enum.reduce_while({0, 0, []}, fn _, {position, acc, already_run} ->
      if Enum.member?(already_run, position) do
        {:halt, {acc, :cycle}}
      else
        case Map.get(program, position) do
          nil ->
            {:halt, {acc, :end}}

          instruction ->
            {new_position, new_acc} = run_instruction(instruction, position, acc)
            {:cont, {new_position, new_acc, [position | already_run]}}
        end
      end
    end)
  end

  def run_instruction({"nop", _}, position, acc), do: {position + 1, acc}
  def run_instruction({"acc", count}, position, acc), do: {position + 1, acc + count}
  def run_instruction({"jmp", count}, position, acc), do: {position + count, acc}
end
