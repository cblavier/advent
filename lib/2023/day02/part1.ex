defmodule Advent.Y2023.Day02.Part1 do
  def run(puzzle) do
    puzzle
    |> parse()
    |> Enum.filter(fn {_index, sets} ->
      Enum.all?(sets, fn items ->
        items
        |> Enum.reduce(%{red: 0, green: 0, blue: 0}, fn {item, count}, acc ->
          %{acc | item => count}
        end)
        |> then(&(&1.red <= 12 and &1.green <= 13 and &1.blue <= 14))
      end)
    end)
    |> Enum.map(fn {index, _items} -> index end)
    |> Enum.sum()
  end

  def parse(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.with_index(1)
    |> Enum.map(fn {line, index} ->
      line
      |> String.split(": ")
      |> Enum.at(-1)
      |> String.split(["; "])
      |> Enum.map(fn set ->
        set
        |> String.split([", "])
        |> Enum.map(fn item ->
          [count, kind] = String.split(item, " ")
          {String.to_atom(kind), String.to_integer(count)}
        end)
      end)
      |> then(&{index, &1})
    end)
  end
end
