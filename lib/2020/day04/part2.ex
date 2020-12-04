defmodule Advent.Y2020.Day04.Part2 do
  alias Advent.Y2020.Day04.Part1

  def run(puzzle) do
    puzzle
    |> String.split("\n\n")
    |> Enum.map(&Part1.parse_passport/1)
    |> Enum.count(&valid_passport?/1)
  end

  def valid_passport?(passport) do
    Part1.has_required_fields?(passport) && Enum.all?(passport, &valid_passport_field?/1)
  end

  defp valid_passport_field?(["byr", value]), do: valid_number_range?(value, 1920..2002)
  defp valid_passport_field?(["iyr", value]), do: valid_number_range?(value, 2010..2020)
  defp valid_passport_field?(["eyr", value]), do: valid_number_range?(value, 2020..2030)
  defp valid_passport_field?(["ecl", value]), do: value in ~w(amb blu brn gry grn hzl oth)
  defp valid_passport_field?(["hcl", value]), do: String.match?(value, ~r/^#[0-9a-f]{6}$/)
  defp valid_passport_field?(["pid", value]), do: String.match?(value, ~r/^[0-9]{9}$/)
  defp valid_passport_field?(["cid", _value]), do: true

  defp valid_passport_field?(["hgt", value]) do
    case Regex.named_captures(~r/(?<num>\d+)(?<unit>cm|in)/, value) do
      %{"num" => num, "unit" => "cm"} -> valid_number_range?(num, 150..193)
      %{"num" => num, "unit" => "in"} -> valid_number_range?(num, 59..76)
      _ -> false
    end
  end

  defp valid_number_range?(nb_s, range) do
    case Integer.parse(nb_s) do
      {nb, ""} -> nb in range
      _ -> false
    end
  end
end
