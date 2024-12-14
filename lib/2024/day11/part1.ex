defmodule Advent.Y2024.Day11.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&count_stones(&1, 25))
    |> Enum.sum()
  end

  def count_stones(_stone, 0), do: 1

  def count_stones(stone, step) do
    case blink(stone) do
      [stone1, stone2] -> count_stones(stone1, step - 1) + count_stones(stone2, step - 1)
      stone -> count_stones(stone, step - 1)
    end
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
end
