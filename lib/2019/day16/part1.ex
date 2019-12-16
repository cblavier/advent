defmodule Advent.Y2019.Day16.Part1 do
  @pattern [0, 1, 0, -1]
  @pattern_length 4

  def run(puzzle, phase_count) do
    puzzle
    |> String.to_integer()
    |> Integer.digits()
    |> fft(phase_count)
    |> Enum.take(8)
    |> Integer.undigits()
  end

  def fft(signal, 0), do: signal

  def fft(signal, phase_count) do
    0..(length(signal) - 1)
    |> Enum.map(&Task.async(fn -> apply_pattern(signal, &1) end))
    |> Enum.map(&Task.await/1)
    |> fft(phase_count - 1)
  end

  def apply_pattern(signal, output_index) do
    signal
    |> Stream.with_index()
    |> Enum.reduce(0, fn
      {_item, index}, acc when index < output_index -> acc
      {item, index}, acc -> acc + pattern_item(output_index, index) * item
    end)
    |> abs()
    |> rem(10)
  end

  def pattern_item(output_index, index) do
    Enum.at(
      @pattern,
      rem(
        floor((index + 1) / (output_index + 1)),
        @pattern_length
      )
    )
  end
end
