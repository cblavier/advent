defmodule Advent.Y2022.Day13.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.chunk_every(3)
    |> Enum.map(fn [p1, p2 | _] ->
      {parse_packet(p1), parse_packet(p2)}
    end)
    |> Enum.with_index(1)
    |> Enum.filter(fn {pair, _index} ->
      pair_ordered?(pair)
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def parse_packet(p) do
    p |> Code.eval_string() |> elem(0)
  end

  def pair_ordered?({p1, p2}) when is_integer(p1) and is_integer(p2) do
    cond do
      p1 < p2 -> true
      p1 > p2 -> false
      p1 == p2 -> nil
    end
  end

  def pair_ordered?({p1, p2}) when is_integer(p1) do
    pair_ordered?({[p1], p2})
  end

  def pair_ordered?({p1, p2}) when is_integer(p2) do
    pair_ordered?({p1, [p2]})
  end

  def pair_ordered?({[], []}), do: nil
  def pair_ordered?({_p1, []}), do: false
  def pair_ordered?({[], _p2}), do: true

  def pair_ordered?({[p1 | p1tail], [p2 | p2tail]}) do
    case pair_ordered?({p1, p2}) do
      nil -> pair_ordered?({p1tail, p2tail})
      bool -> bool
    end
  end
end
