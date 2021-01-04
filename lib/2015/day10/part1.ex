defmodule Advent.Y2015.Day10.Part1 do
  def run(puzzle) do
    puzzle |> look_and_say(40) |> length()
  end

  def look_and_say(seq, 0), do: seq

  def look_and_say(seq, n) when is_binary(seq) do
    seq |> String.graphemes() |> look_and_say(n)
  end

  def look_and_say(seq, n) do
    seq
    |> Enum.chunk_while(
      [],
      fn
        c, [] -> {:cont, [c]}
        c, acc = [c | _tail] -> {:cont, [c | acc]}
        c, acc = [_ | _tail] -> {:cont, repeat(acc), [c]}
      end,
      fn
        [] -> {:cont, []}
        acc -> {:cont, repeat(acc), []}
      end
    )
    |> List.flatten()
    |> look_and_say(n - 1)
  end

  def repeat(s = [h | _]), do: [s |> length() |> to_string(), h]
end
