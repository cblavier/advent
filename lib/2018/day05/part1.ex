defmodule Advent.Y2018.Day05.Part1 do
  @reaction_delta ?a - ?A

  def run(puzzle) do
    puzzle
    |> String.to_charlist()
    |> resolve()
    |> Enum.count()
  end

  defguard reacts(u1, u2) when abs(u2 - u1) == @reaction_delta

  def resolve(puzzle) do
    List.foldr(puzzle, [], fn
      unit, [] -> [unit]
      u1, [u2] when reacts(u1, u2) -> []
      u1, [u2] -> [u1, u2]
      u1, [u2 | tail] when reacts(u1, u2) -> tail
      u1, [u2 | tail] -> [u1, u2 | tail]
    end)
  end
end
