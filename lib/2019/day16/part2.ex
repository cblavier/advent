defmodule Advent.Y2019.Day16.Part2 do
  def run(puzzle, phase_count) do
    signal =
      puzzle
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> expand_signal(10_000)

    1..phase_count
    |> Enum.reduce(signal, &fft/2)
    |> Enum.take(8)
    |> Enum.join("")
  end

  defp expand_signal(signal, count) do
    signal = List.duplicate(signal, count) |> List.flatten()
    skip_index = Enum.take(signal, 7) |> Enum.join() |> String.to_integer()
    Enum.drop(signal, skip_index)
  end

  def fft(_, signal) do
    signal
    |> Enum.reverse()
    |> Enum.scan(0, fn x, acc -> abs(acc + x) |> rem(10) end)
    |> Enum.reverse()
  end
end
