defmodule Advent.Y2020.Day05.Part1 do
  @row_range 0..127
  @col_range 0..7

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&find_seat(&1, @row_range, @col_range))
    |> Enum.map(&boarding_id/1)
    |> Enum.max()
  end

  def find_seat(boarding_pass, row_range, col_range) do
    {[row], [col]} =
      boarding_pass
      |> String.graphemes()
      |> Enum.reduce({row_range, col_range}, fn
        "F", {row_range, col_range} -> {chop_range(row_range, :lower), col_range}
        "B", {row_range, col_range} -> {chop_range(row_range, :upper), col_range}
        "L", {row_range, col_range} -> {row_range, chop_range(col_range, :lower)}
        "R", {row_range, col_range} -> {row_range, chop_range(col_range, :upper)}
      end)

    {row, col}
  end

  def chop_range(range, bound) do
    new_size = round(Enum.count(range) / 2)

    case bound do
      :lower -> Enum.slice(range, 0, new_size)
      :upper -> Enum.slice(range, new_size, new_size)
    end
  end

  def boarding_id({row, col}), do: row * 8 + col
end
