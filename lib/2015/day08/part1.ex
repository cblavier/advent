defmodule Advent.Y2015.Day08.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&(String.length(&1) - memory_length(&1)))
    |> Enum.sum()
  end

  def memory_length(line) do
    line
    |> String.to_charlist()
    |> Enum.chunk_while(
      [],
      fn
        ?x, [?\\] -> {:cont, [?\\, ?x]}
        c, [?\\, ?x] -> {:cont, [?\\, ?x, c]}
        c2, [?\\, ?x, c1] -> {:cont, [?\\, ?x, c1, c2], []}
        c1, [c2] -> {:cont, [c2, c1], []}
        ?", [] -> {:cont, []}
        ?\\, [] -> {:cont, [?\\]}
        c, [] -> {:cont, [c], []}
      end,
      fn acc -> {:cont, acc} end
    )
    |> length()
  end
end
