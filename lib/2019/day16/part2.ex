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
    |> Integer.undigits()
  end

  defp expand_signal(signal, count) do
    signal = List.duplicate(signal, count) |> List.flatten()
    skip_index = Enum.take(signal, 7) |> Enum.join() |> String.to_integer()
    Enum.drop(signal, skip_index)
  end

  def fft(_, signal) do
    signal
    |> List.foldr(
      {0, []},
      fn item, {acc, signal} -> {acc + item, [rem(acc + item, 10) | signal]} end
    )
    |> elem(1)
  end
end
