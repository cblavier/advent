defmodule Advent.Y2019.Day13.Part1 do
  alias Advent.Y2019.Computer

  @block_tile 2

  def run(puzzle) do
    puzzle
    |> Computer.parse_program()
    |> Computer.run_program()
    |> draw_stage()
    |> count_blocks()
  end

  def draw_stage({:ok, instructions}) do
    instructions
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.reduce(%{}, fn [x, y, tile_id], stage ->
      Map.put(stage, {x, y}, tile_id)
    end)
  end

  def count_blocks(stage) do
    stage |> Map.values() |> Enum.count(&(&1 == @block_tile))
  end
end
