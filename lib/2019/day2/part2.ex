defmodule Advent.Y2019.Day2.Part2 do
  alias Advent.Y2019.Day2.Part1

  @max_noun 100
  @max_verb 100

  def run(path, expected) do
    code =
      path
      |> File.read!()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    for noun <- 0..@max_noun, verb <- 0..@max_verb do
      if Part1.run_code_with_state(code, {noun, verb}) == expected do
        throw({noun, verb})
      end
    end

    :error
  catch
    {noun, verb} -> 100 * noun + verb
  end
end
