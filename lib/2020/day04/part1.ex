defmodule Advent.Y2020.Day04.Part1 do
  @required_fields ["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"]

  def run(puzzle) do
    puzzle
    |> String.split("\n\n")
    |> Enum.map(&parse_passport/1)
    |> Enum.count(&has_required_fields?/1)
  end

  def parse_passport(passport) do
    passport
    |> String.split([" ", "\n"])
    |> Enum.map(&String.split(&1, ":"))
  end

  def has_required_fields?(passport) do
    fields = Enum.map(passport, &hd/1)
    Enum.empty?(@required_fields -- fields)
  end
end
