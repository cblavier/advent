defmodule Advent.Y2015.Day13.Part1 do
  def run(puzzle) do
    {happiness_changes, guests} = parse(puzzle)

    guests
    |> guest_pair_combinations()
    |> Enum.map(&apply_happiness(&1, happiness_changes))
    |> Enum.max()
  end

  @regex ~r/(?<g1>\w+) would (?<kind>gain|lose) (?<change>\d+) .* next to (?<g2>\w+)/
  def parse(puzzle) do
    for line <- String.split(puzzle, "\n"), reduce: {%{}, MapSet.new()} do
      {acc, guests} ->
        %{"g1" => g1, "g2" => g2, "kind" => kind, "change" => change} =
          Regex.named_captures(@regex, line)

        change =
          case kind do
            "gain" -> String.to_integer(change)
            "lose" -> -String.to_integer(change)
          end

        {Map.put(acc, [g1, g2], change), MapSet.put(guests, g1)}
    end
  end

  def guest_pair_combinations(guests) do
    for permutation <- guests |> Enum.to_list() |> permutations() do
      pairs = Enum.chunk_every(permutation, 2, 1, :discard)
      pairs ++ [[Enum.at(permutation, -1), Enum.at(permutation, 0)]]
    end
  end

  def permutations([]), do: [[]]
  def permutations(list), do: for(i <- list, rest <- permutations(list -- [i]), do: [i | rest])

  def apply_happiness(pairs, happiness_changes) do
    pairs
    |> Enum.map(fn [g1, g2] ->
      Map.get(happiness_changes, [g1, g2], 0) +
        Map.get(happiness_changes, [g2, g1], 0)
    end)
    |> Enum.sum()
  end
end
