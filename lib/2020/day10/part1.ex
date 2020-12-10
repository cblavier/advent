defmodule Advent.Y2020.Day10.Part1 do
  def run(puzzle) do
    {diff_1, diff_3, _} =
      puzzle
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()
      |> find_chain()

    diff_1 * diff_3
  end

  def find_chain(joltages) do
    Enum.reduce(joltages, {0, 1, 0}, fn
      joltage, {diffs_1, diffs_3, last_joltage} when joltage - last_joltage == 1 ->
        {diffs_1 + 1, diffs_3, joltage}

      joltage, {diffs_1, diffs_3, last_joltage} when joltage - last_joltage == 3 ->
        {diffs_1, diffs_3 + 1, joltage}
    end)
  end
end
