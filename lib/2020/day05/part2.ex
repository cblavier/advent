defmodule Advent.Y2020.Day05.Part2 do
  alias Advent.Y2020.Day05.Part1

  @row_range 0..127
  @col_range 0..7

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&Part1.find_seat(&1, @row_range, @col_range))
    |> find_candidates(@row_range, @col_range)
    |> Enum.map(&Part1.boarding_id/1)
    |> find_matching_seat()
  end

  defp find_candidates(seats, row_range = min_row..max_row, col_range) do
    for row <- row_range,
        col <- col_range,
        row != min_row,
        row != max_row,
        {row, col} not in seats do
      {row, col}
    end
  end

  defp find_matching_seat(boarding_ids) do
    boarding_ids
    |> Enum.chunk_every(3, 1)
    |> Enum.filter(&(length(&1) == 3))
    |> Enum.filter(fn [a, b, c] -> a + 1 != b && b + 1 != c end)
    |> hd()
    |> Enum.at(1)
  end
end
