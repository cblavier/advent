defmodule Advent.Y2023.Day04.Part2 do
  import Advent.Y2023.Day04.Part1

  def run(puzzle) do
    puzzle = parse(puzzle)
    size = Enum.count(puzzle)

    puzzle =
      for card <- puzzle, reduce: %{} do
        acc -> Map.put(acc, card.index, card)
      end

    for i <- 1..size, reduce: puzzle do
      puzzle ->
        card = Map.get(puzzle, i)

        case winning_count(card) do
          0 ->
            puzzle

          n ->
            for j <- 1..n, k = i + j, k <= size, reduce: puzzle do
              puzzle ->
                Map.update!(puzzle, k, &%{&1 | count: &1.count + card.count})
            end
        end
    end
    |> Enum.map(&(&1 |> elem(1) |> Map.get(:count)))
    |> Enum.sum()
  end
end
