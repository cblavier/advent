defmodule Advent.Y2020.Day23.Part1 do
  @max 9
  @steps 100

  def run(puzzle) do
    sequence = build_sequence(puzzle)
    circle = build_circle(sequence)

    1..@steps
    |> Enum.reduce({hd(sequence), circle}, fn _, {current, circle} ->
      move(circle, current, @max)
    end)
    |> elem(1)
    |> print_circle(1, @max)
  end

  def build_sequence(puzzle) do
    puzzle |> String.graphemes() |> Enum.map(&String.to_integer/1)
  end

  def build_circle(sequence = [first | _]) do
    sequence
    |> Enum.chunk_every(2, 1)
    |> Enum.reduce(%{}, fn
      [n, next], acc -> Map.put(acc, n, next)
      [n], acc -> Map.put(acc, n, first)
    end)
  end

  def move(circle, current, max) do
    pick_up = [a, _b, c] = pick_up(circle, current)
    dest = dest(current, pick_up, max)
    {after_pick_up, circle} = Map.get_and_update(circle, dest, fn n -> {n, a} end)
    {new_current, circle} = Map.get_and_update(circle, c, fn n -> {n, after_pick_up} end)
    circle = Map.put(circle, current, new_current)
    {new_current, circle}
  end

  def pick_up(circle, current) do
    a = Map.get(circle, current)
    b = Map.get(circle, a)
    c = Map.get(circle, b)
    [a, b, c]
  end

  def dest(current, pick_up, max) do
    dest = if current == 1, do: max, else: current - 1
    if dest in pick_up, do: dest(dest, pick_up, max), else: dest
  end

  def print_circle(circle, start, max) do
    Enum.reduce_while(1..max, {start, ""}, fn _, {cup, acc} ->
      case Map.get(circle, cup) do
        ^start -> {:halt, acc}
        val -> {:cont, {val, acc <> to_string(val)}}
      end
    end)
  end
end
