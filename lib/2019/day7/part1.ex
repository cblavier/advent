defmodule Advent.Y2019.Day7.Part1 do
  alias Advent.Y2019.Day5, as: Computer

  @doc ~S"""
  iex> alias Advent.Y2019.Day7.Part1
  iex> program = "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0"
  iex> Part1.run(program)
  43_210
  iex> program = "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0"
  iex> Part1.run(program)
  54_321
  iex> program = "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0"
  iex> Part1.run(program)
  65_210
  """
  def run(puzzle) do
    puzzle |> Computer.parse_program() |> compute()
  end

  def compute(program, input \\ 0) do
    for signals <- permutations([0, 1, 2, 3, 4]) do
      Task.async(fn ->
        Enum.reduce(signals, input, fn signal, input ->
          [output | _tail] = Computer.run_program(program, [signal, input])
          output
        end)
      end)
    end
    |> Enum.map(&Task.await/1)
    |> Enum.max()
  end

  def permutations([]), do: [[]]

  def permutations(list) do
    for elem <- list,
        rest <- permutations(list -- [elem]),
        do: [elem | rest]
  end
end
