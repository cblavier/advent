defmodule Advent.Y2017.Day19.Part1 do
  def run(puzzle) do
    puzzle |> parse() |> explore() |> elem(0)
  end

  def parse(puzzle) do
    for {line, y} <- puzzle |> String.split("\n") |> Enum.with_index(),
        {char, x} <- line |> String.graphemes() |> Enum.with_index(),
        into: %{},
        do: {{x, y}, if(char == " ", do: nil, else: char)}
  end

  def explore(network) do
    start = find_start(network)

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(
      %{pos: start, dir: :down, letters: [], count: 0},
      fn i, %{pos: pos, dir: dir, letters: letters} ->
        case next(network, pos, dir) do
          {:halt, collected} ->
            {:halt, {Enum.join(letters ++ collected), i}}

          {:cont, {pos, dir, collected}} ->
            {:cont, %{pos: pos, dir: dir, letters: letters ++ collected}}
        end
      end
    )
  end

  def find_start(network) do
    Enum.find_value(network, fn
      {{x, 0}, "|"} -> {x, 0}
      _ -> false
    end)
  end

  def next(network, pos, dir) do
    val = Map.get(network, pos)
    collected = if String.match?(val, ~r/[A-Z]/), do: [val], else: []

    case can_go?(network, pos, dir) do
      false -> {:halt, collected}
      {pos, dir} -> {:cont, {pos, dir, collected}}
    end
  end

  def can_go?(network, pos, dir) do
    case {Map.get(network, pos), dir} do
      {"+", :up} -> maybe_go(network, [ahead(pos, :up), ahead(pos, :right), ahead(pos, :left)])
      {"+", :down} -> maybe_go(network, [ahead(pos, :down), ahead(pos, :right), ahead(pos, :left)])
      {"+", :left} -> maybe_go(network, [ahead(pos, :up), ahead(pos, :down), ahead(pos, :left)])
      {"+", :right} -> maybe_go(network, [ahead(pos, :up), ahead(pos, :right), ahead(pos, :down)])
      {_, dir} -> maybe_go(network, [ahead(pos, dir)])
    end
  end

  def ahead({x, y}, :up), do: {{x, y - 1}, :up}
  def ahead({x, y}, :down), do: {{x, y + 1}, :down}
  def ahead({x, y}, :left), do: {{x - 1, y}, :left}
  def ahead({x, y}, :right), do: {{x + 1, y}, :right}

  def maybe_go(network, pos_and_dirs) do
    pos_dir_and_vals = for {p, d} <- pos_and_dirs, do: {p, d, Map.get(network, p)}

    case Enum.find(pos_dir_and_vals, fn {_pos, _dir, val} -> val end) do
      {pos, dir, _val} -> {pos, dir}
      _ -> false
    end
  end
end
