defmodule Advent.Y2020.Day16.Part1 do
  import String, only: [to_integer: 1]

  def run(puzzle) do
    [rules, _ticket, nearby_tickets] = String.split(puzzle, "\n\n")
    rules = parse_rules(rules)

    nearby_tickets
    |> parse_tickets()
    |> invalid_fields(rules)
    |> Enum.sum()
  end

  def parse_rules(rules) do
    rules
    |> String.split("\n")
    |> Enum.map(fn rule ->
      %{"name" => name, "i1" => i1, "i2" => i2, "i3" => i3, "i4" => i4} =
        Regex.named_captures(
          ~r/(?<name>[\w\s]+): (?<i1>\d+)-(?<i2>\d+) or (?<i3>\d+)-(?<i4>\d+)/,
          rule
        )

      {name, to_integer(i1)..to_integer(i2), to_integer(i3)..to_integer(i4)}
    end)
  end

  def parse_tickets(tickets) do
    tickets
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&parse_ticket/1)
  end

  def parse_ticket(t), do: t |> String.split(",") |> Enum.map(&to_integer/1)

  def invalid_fields(tickets, rules) do
    Enum.flat_map(tickets, fn ticket ->
      Enum.reject(ticket, &valid_field?(&1, rules))
    end)
  end

  def valid_field?(field, {_, r1, r2}), do: field in r1 || field in r2
  def valid_field?(field, rules), do: Enum.any?(rules, &valid_field?(field, &1))
end
