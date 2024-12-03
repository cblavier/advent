defmodule Advent.Y2024.Day03.Part2 do
  alias Advent.Y2024.Day03.Part1

  def run(puzzle) do
    Regex.split(~r/mul\(\d+,\d+\)|(do\(\))|(don't\(\))/, puzzle, include_captures: true)
    |> Enum.reduce(%{sum: 0, enabled: true}, fn
      "do()", acc ->
        %{acc | enabled: true}

      "don't()", acc ->
        %{acc | enabled: false}

      s, acc = %{enabled: true, sum: sum} ->
        if String.match?(s, ~r|mul\(\d+,\d+\)|) do
          %{acc | sum: sum + Part1.evaluate_mul(s)}
        else
          acc
        end

      _, acc ->
        acc
    end)
    |> Map.get(:sum)
  end
end
