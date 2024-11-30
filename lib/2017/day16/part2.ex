defmodule Advent.Y2017.Day16.Part2 do
  alias Advent.Y2017.Day16.Part1

  def run(puzzle) do
    programs = Part1.build_program()
    instructions = Part1.parse(puzzle)

    period =
      Stream.iterate(1, &(&1 + 1))
      |> Enum.reduce_while(programs, fn i, acc ->
        case Part1.move(instructions, acc) do
          ^programs -> {:halt, i}
          programs -> {:cont, programs}
        end
      end)

    Enum.reduce(1..rem(1_000_000_000, period), programs, fn _i, acc ->
      Part1.move(instructions, acc)
    end)
    |> Part1.programs_to_string()
  end
end
