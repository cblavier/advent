defmodule Advent.Y2017.Day10.Part1 do
  @list_length 256

  def run(puzzle) do
    puzzle = parse(puzzle)
    list = build_list(@list_length) |> process(puzzle)
    Map.get(list, 0) * Map.get(list, 1)
  end

  def process(list, puzzle, rounds \\ 1, pos \\ 0, skip \\ 0)
  def process(list, _puzzle, 0, _pos, _skip), do: list

  def process(list, puzzle, rounds, pos, skip) do
    %{list: list, pos: pos, skip: skip} =
      for length <- puzzle, reduce: %{list: list, pos: pos, skip: skip} do
        %{list: list, pos: pos, skip: skip} ->
          %{
            list: reverse(list, pos, length, @list_length),
            pos: rem(pos + length + skip, @list_length),
            skip: skip + 1
          }
      end

    process(list, puzzle, rounds - 1, pos, skip)
  end

  def parse(puzzle) do
    puzzle |> String.split(",") |> Enum.map(&String.to_integer/1)
  end

  def build_list(length) do
    for i <- 0..(length - 1), reduce: %{} do
      acc -> Map.put(acc, i, i)
    end
  end

  def reverse(list, pos, length, list_length) do
    for i <- 0..(length - 1),
        j = rem(pos + i, list_length),
        k = rem(pos + length - 1 - i, list_length),
        reduce: list do
      acc -> Map.put(acc, j, Map.get(list, k))
    end
  end
end
