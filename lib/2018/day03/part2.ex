defmodule Advent.Y2018.Day03.Part2 do
  alias Advent.Y2018.Day03.Part1

  def run(puzzle) do
    claims =
      puzzle
      |> String.split("\n")
      |> Enum.map(&Part1.parse_claim/1)
      |> build_claim_map()

    claims
    |> Map.values()
    |> Part1.build_fabric()
    |> non_overlapping_claim_counts()
    |> full_claims(claims)
    |> Enum.at(0)
    |> elem(0)
  end

  defp build_claim_map(claims) do
    Enum.reduce(claims, %{}, fn claim = %{id: id}, acc ->
      Map.put(acc, id, claim)
    end)
  end

  defp non_overlapping_claim_counts(fabric) do
    fabric
    |> Map.values()
    |> Enum.filter(&(length(&1) == 1))
    |> Enum.reduce(%{}, fn [id], counts ->
      Map.update(counts, id, 1, &(&1 + 1))
    end)
  end

  defp full_claims(claim_counts, claims) do
    Enum.filter(claim_counts, fn {id, count} ->
      claims |> Map.get(id) |> claim_size() == count
    end)
  end

  defp claim_size(%{w: w, h: h}), do: w * h
end
