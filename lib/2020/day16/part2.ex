defmodule Advent.Y2020.Day16.Part2 do
  alias Advent.Y2020.Day16.Part1

  def run(puzzle) do
    [rules, ticket, nearby_tickets] = String.split(puzzle, "\n\n")
    rules = Part1.parse_rules(rules)

    field_indexes =
      nearby_tickets
      |> Part1.parse_tickets()
      |> Enum.filter(&valid_ticket?(&1, rules))
      |> find_field_candidates(rules)
      |> reduce_candidates()

    ticket
    |> parse_ticket()
    |> field_values(field_indexes, "departure")
    |> Enum.reduce(1, fn val, acc -> val * acc end)
  end

  def parse_ticket(t), do: t |> String.split("\n") |> Enum.at(1) |> Part1.parse_ticket()

  def valid_ticket?(t, rules), do: Enum.all?(t, &Part1.valid_field?(&1, rules))

  def find_field_candidates(tickets, rules) do
    tickets
    |> Enum.zip()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {field_values, index}, acc ->
      rules
      |> Enum.filter(&valid_field_values?(field_values, &1))
      |> Enum.reduce(acc, fn rule, acc ->
        Map.update(acc, index, [rule], &[rule | &1])
      end)
    end)
  end

  def valid_field_values?(field_values, rule) do
    field_values
    |> Tuple.to_list()
    |> Enum.all?(&Part1.valid_field?(&1, rule))
  end

  def reduce_candidates(candidates) do
    new =
      Enum.reduce(candidates, candidates, fn
        {_index, [rule]}, acc -> remove_from_candidates(acc, rule)
        _, acc -> acc
      end)

    if new == candidates, do: candidates, else: reduce_candidates(new)
  end

  def remove_from_candidates(candidates, rule) do
    candidates
    |> Enum.map(fn
      {index, [rule]} -> {index, [rule]}
      {index, rules} -> {index, Enum.reject(rules, &(&1 == rule))}
    end)
    |> Map.new()
  end

  def field_values(ticket, indexes, prefix) do
    indexes
    |> Enum.filter(fn {_, [{name, _, _}]} -> String.starts_with?(name, prefix) end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.reduce([], fn index, acc -> [Enum.at(ticket, index) | acc] end)
  end
end
