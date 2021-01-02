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
    circle = :atomics.new(length(sequence), [])

    sequence
    |> Enum.chunk_every(2, 1)
    |> Enum.each(fn
      [n, next] -> :atomics.put(circle, n, next)
      [n] -> :atomics.put(circle, n, first)
    end)

    circle
  end

  def move(circle, current, max) do
    pick_up = [a, _b, c] = pick_up(circle, current)
    dest = dest(current, pick_up, max)
    after_pick_up = :atomics.exchange(circle, dest, a)
    new_current = :atomics.exchange(circle, c, after_pick_up)
    :atomics.put(circle, current, new_current)
    {new_current, circle}
  end

  def pick_up(circle, current) do
    a = :atomics.get(circle, current)
    b = :atomics.get(circle, a)
    c = :atomics.get(circle, b)
    [a, b, c]
  end

  def dest(current, pick_up, max) do
    dest = if current == 1, do: max, else: current - 1
    if dest in pick_up, do: dest(dest, pick_up, max), else: dest
  end

  def print_circle(circle, start, max) do
    Enum.reduce_while(1..max, {start, ""}, fn _, {cup, acc} ->
      case :atomics.get(circle, cup) do
        ^start -> {:halt, acc}
        val -> {:cont, {val, acc <> to_string(val)}}
      end
    end)
  end
end
