defmodule Advent.Y2019.Day16.Part1 do
  @pattern [0, 1, 0, -1]
  @pattern_length 4

  @doc ~S"""
  iex> alias Advent.Y2019.Day16.Part1
  iex> Part1.run("12345678", 1)
  "48226158"
  iex> Part1.run("12345678", 4)
  "01029498"
  iex> Part1.run("69317163492948606335995924319873", 1)
  "24292942"
  iex> Part1.run("69317163492948606335995924319873", 2)
  "52872974"
  iex> Part1.run("69317163492948606335995924319873", 100)
  "52432133"
  """
  def run(puzzle, phase_count) do
    puzzle
    |> String.graphemes()
    |> fft(phase_count)
    |> Enum.slice(0, 8)
    |> Enum.join("")
  end

  def fft(signal, 0), do: signal

  def fft(signal, phase_count) do
    signal = Enum.map(signal, &String.to_integer/1)

    0..(length(signal) - 1)
    |> Enum.map(&Task.async(fn -> apply_pattern(signal, &1) end))
    |> Enum.map(&Task.await/1)
    |> fft(phase_count - 1)
  end

  def apply_pattern(signal, output_index) do
    Enum.sum(
      for {signal_item, index} <- Enum.with_index(signal),
          pattern_item = pattern_item(output_index, index),
          pattern_item != 0,
          do: signal_item * pattern_item
    )
    |> abs()
    |> rem(10)
    |> to_string()
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
