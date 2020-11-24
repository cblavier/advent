defmodule Advent.Y2018.Day05.Part1 do
  def run(puzzle) do
    puzzle |> String.to_charlist() |> resolve() |> length()
  end

  defguard reacts(u1, u2) when abs(u2 - u1) == ?a - ?A

  def resolve(puzzle) do
    Enum.reduce(puzzle, [], fn
      unit, [] -> [unit]
      u1, [u2] when reacts(u1, u2) -> []
      u1, [u2] -> [u1, u2]
      u1, [u2 | tail] when reacts(u1, u2) -> tail
      u1, [u2 | tail] -> [u1, u2 | tail]
    end)
  end
end
