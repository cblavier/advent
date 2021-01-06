defmodule Advent.Y2015.Day17.Part1 do
  @buckets [5, 5, 10, 15, 20]

  def run(_puzzle) do
    1..length(@buckets)
    |> Enum.flat_map(fn n -> @buckets |> Enum.with_index() |> permutations(n) end)
    |> Enum.filter(fn permutation ->
      permutation |> Enum.map(&elem(&1, 0)) |> Enum.sum() == 25
    end)
    |> Enum.map(&Enum.sort/1)
    |> Enum.uniq()
  end

  def permutations([], _n), do: [[]]
  def permutations(_list, 0), do: [[]]

  def permutations(list, n) do
    for head <- list,
        tail <- permutations(list -- [head], n - 1),
        do: [head | tail]
  end
end
