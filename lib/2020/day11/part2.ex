defmodule Advent.Y2020.Day11.Part2 do
  alias Advent.Y2020.Day11.Part1

  @seat_directions [{1, 1}, {1, 0}, {1, -1}, {0, 1}, {0, -1}, {-1, 1}, {-1, 0}, {-1, -1}]

  def run(puzzle) do
    puzzle = String.split(puzzle, "\n")

    puzzle
    |> Part1.build_grid()
    |> Part1.with_dimensions(puzzle)
    |> Part1.evolve(&adjacents/3, &Part1.should_turn_occupied?/1, &should_turn_free?/1)
    |> Part1.count_occupied()
  end

  def adjacents(grid, x, y) do
    Enum.reduce(
      @seat_directions,
      [],
      fn {shift_x, shift_y}, acc ->
        Stream.cycle([0])
        |> Enum.reduce_while({acc, x, y}, fn _, {acc, x, y} ->
          {new_x, new_y} = {x + shift_x, y + shift_y}

          case Map.get(grid, {new_x, new_y}) do
            "." -> {:cont, {acc, new_x, new_y}}
            nil -> {:halt, acc}
            seat -> {:halt, [seat | acc]}
          end
        end)
      end
    )
  end

  def should_turn_free?(adjacents) do
    Enum.count(adjacents, &(&1 == "#")) >= 5
  end
end
