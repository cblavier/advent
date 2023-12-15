defmodule Advent.Y2023.Day04.Part1 do
  defmodule Card do
    defstruct [:index, :winning, :having, count: 1]
  end

  def run(puzzle) do
    puzzle
    |> parse()
    |> Enum.reduce(0, fn card, acc -> acc + score(card) end)
  end

  def parse(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.with_index(1)
    |> Enum.map(fn {line, index} ->
      [_header, winning, having] = String.split(line, [": ", " | "])

      %Card{
        index: index,
        winning: parse_ints(winning),
        having: parse_ints(having)
      }
    end)
  end

  defp parse_ints(s) do
    s
    |> String.split(" ")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.to_integer/1)
  end

  defp score(card) do
    case winning_count(card) do
      0 -> 0
      n -> round(:math.pow(2, n - 1))
    end
  end

  def winning_count(%Card{winning: winning, having: having}) do
    MapSet.intersection(
      MapSet.new(winning),
      MapSet.new(having)
    )
    |> Enum.count()
  end
end
