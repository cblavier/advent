defmodule Advent.Y2018.Day03.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&parse_claim/1)
    |> build_fabric()
    |> Map.values()
    |> Enum.filter(&(length(&1) > 1))
    |> Enum.count()
  end

  @claim_regex Regex.compile!(~S/#(?<id>\d+) @ (?<x>\d+)\,(?<y>\d+): (?<w>\d+)x(?<h>\d+)/)
  def parse_claim(claim) do
    %{"id" => id, "x" => x, "y" => y, "w" => w, "h" => h} =
      Regex.named_captures(@claim_regex, claim)

    %{
      id: String.to_integer(id),
      x: String.to_integer(x),
      y: String.to_integer(y),
      w: String.to_integer(w),
      h: String.to_integer(h)
    }
  end

  def build_fabric(claims) do
    Enum.reduce(claims, %{}, fn %{id: id, x: x, y: y, w: w, h: h}, fabric ->
      Enum.reduce(x..(x + w - 1), fabric, fn x, fabric ->
        Enum.reduce(y..(y + h - 1), fabric, fn y, fabric ->
          Map.update(fabric, {x, y}, [id], &[id | &1])
        end)
      end)
    end)
  end
end
