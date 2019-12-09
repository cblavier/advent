defmodule Advent.Y2019.Day9 do
  alias Advent.Y2019.Day5, as: Computer

  @doc ~S"""
  iex> alias Advent.Y2019.Day9
  iex> Day9.run("109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99", "1") |> Enum.join(",")
  "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
  iex> Day9.run("1102,34915192,34915192,7,4,7,99,0", "1")
  [1219070632396864]
  iex> Day9.run("104,1125899906842624,99", "1")
  [1125899906842624]
  """
  def run(puzzle, input) do
    puzzle
    |> Computer.parse_program()
    |> Computer.run_program([input])
  end
end
