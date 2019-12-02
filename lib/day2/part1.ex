defmodule Advent2019.Day2.Part1 do
  def run(path) do
    opcodes =
      path
      |> File.read!()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    opcodes
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> run_code()
    |> Enum.at(0)
  end

  @doc ~S"""
  ## Examples
    iex> alias Advent2019.Day2.Part1
    iex> Part1.run_code([1, 0, 0, 0, 99])
    [2, 0, 0, 0, 99]
    iex> Part1.run_code([2, 3, 0, 3, 99])
    [2, 3, 0, 6, 99]
    iex> Part1.run_code([2, 4, 4, 5, 99, 0])
    [2, 4, 4, 5, 99, 9801]
    iex> Part1.run_code([1, 1, 1, 4, 99, 5, 6, 0, 99])
    [30, 1, 1, 4, 2, 5, 6, 0, 99]
  """
  def run_code(opcodes, index \\ 0) do
    case Enum.slice(opcodes, index, 4) do
      [1, idx1, idx2, pos] ->
        value = Enum.at(opcodes, idx1) + Enum.at(opcodes, idx2)
        opcodes |> List.replace_at(pos, value) |> run_code(index + 4)

      [2, idx1, idx2, pos] ->
        value = Enum.at(opcodes, idx1) * Enum.at(opcodes, idx2)
        opcodes |> List.replace_at(pos, value) |> run_code(index + 4)

      [99 | _] ->
        opcodes
    end
  end
end
