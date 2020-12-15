defmodule Advent.Y2020.Day15.Part1 do
  def run(puzzle, last_turn) do
    puzzle_length = length(String.split(puzzle, ","))

    puzzle
    |> build_initial_acc()
    |> play_game((puzzle_length + 1)..last_turn)
    |> elem(0)
  end

  def build_initial_acc(puzzle) do
    puzzle
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.reduce({nil, %{}}, fn {n, index}, {_last, spokens} ->
      {n, Map.put(spokens, n, [index + 1])}
    end)
  end

  def play_game(acc, turns) do
    Enum.reduce(turns, acc, fn n, {last, spokens} ->
      new_spoken =
        case Map.get(spokens, last) do
          [_head] -> 0
          [head1, head2] -> head1 - head2
          [head1, head2 | _] -> head1 - head2
        end

      spokens = Map.update(spokens, new_spoken, [n], fn [h | _] -> [n, h] end)
      {new_spoken, spokens}
    end)
  end
end
