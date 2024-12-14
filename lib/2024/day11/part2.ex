defmodule Advent.Y2024.Day11.Part2 do
  @table :Y2024_day_11_part2

  def run(puzzle) do
    :ets.new(@table, [:named_table])

    puzzle
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&count_stones(&1, 75))
    |> Enum.sum()
  end

  def count_stones(_stone, 0), do: 1

  def count_stones(stone, n) do
    memoize({stone, n}, fn ->
      case blink(stone) do
        [s1, s2] -> count_stones(s1, n - 1) + count_stones(s2, n - 1)
        stone -> count_stones(stone, n - 1)
      end
    end)
  end

  def blink(0), do: 1

  def blink(stone) do
    digit_count = floor(:math.log10(stone)) + 1

    if rem(digit_count, 2) == 0 do
      n = :math.pow(10, div(digit_count, 2)) |> round()
      [div(stone, n), rem(stone, n)]
    else
      stone * 2024
    end
  end

  def memoize(key, fun) do
    case :ets.lookup(@table, key) do
      [{^key, val}] -> val
      [] -> fun.() |> tap(&:ets.insert(@table, {key, &1}))
    end
  end
end
