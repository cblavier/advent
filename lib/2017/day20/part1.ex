defmodule Advent.Y2017.Day20.Part1 do
  def run(puzzle) do
    puzzle
    |> parse()
    |> Enum.map(fn %{ax: ax, ay: ay, az: az} -> abs(ax) + abs(ay) + abs(az) end)
    |> Enum.with_index()
    |> Enum.min(&(elem(&1, 0) < elem(&2, 0)))
    |> elem(1)
  end

  def parse(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn line ->
      ~r/p=<(?<x>-?\d+),(?<y>-?\d+),(?<z>-?\d+)>, v=<(?<vx>-?\d+),(?<vy>-?\d+),(?<vz>-?\d+)>, a=<(?<ax>-?\d+),(?<ay>-?\d+),(?<az>-?\d+)>/
      |> Regex.named_captures(line)
      |> Enum.map(fn {k, v} -> {String.to_atom(k), String.to_integer(v)} end)
      |> Map.new()
    end)
  end
end
