defmodule Advent.Y2022.Day13.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.chunk_every(3)
    |> Enum.map(fn [p1, p2 | _] ->
      {parse_packet(p1), parse_packet(p2)}
    end)
    |> Enum.with_index()
    |> Enum.filter(fn {pair, _index} ->
      pair_ordered?(pair)
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  defp parse_packet(p) do
    p |> Code.eval_string() |> elem(0)
  end

  defp pair_ordered?(_pair), do: true
end
