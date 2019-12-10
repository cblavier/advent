defmodule Advent.Y2019.Day02.Part2 do
  alias Advent.Y2019.Day02.Part1

  @max_noun 100
  @max_verb 100

  import String, only: [split: 2, to_integer: 1]

  def run(puzzle, expected) do
    code = puzzle |> split(",") |> Enum.map(&to_integer/1)
    pid = self()

    for noun <- 0..@max_noun, verb <- 0..@max_verb do
      spawn(fn ->
        if Part1.run_code_with_state(code, {noun, verb}) == expected do
          send(pid, {:result, noun, verb})
        end
      end)
    end

    receive do
      {:result, noun, verb} -> 100 * noun + verb
    end
  end
end
