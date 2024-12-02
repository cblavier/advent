defmodule Advent.Y2024.Day02.Part1 do
  def run(puzzle) do
    puzzle |> parse() |> Enum.count(&safe?/1)
  end

  def parse(puzzle) do
    for line <- String.split(puzzle, "\n") do
      line |> String.split(" ") |> Enum.map(&String.to_integer/1)
    end
  end

  def safe?(report) do
    with true <- report == Enum.sort(report) || report == Enum.sort(report, :desc),
         chunks <- Enum.chunk_every(report, 2, 1, :discard) do
      Enum.all?(chunks, fn [a, b] -> abs(a - b) in 1..3 end)
    else
      _ -> false
    end
  end
end
