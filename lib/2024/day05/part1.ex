defmodule Advent.Y2024.Day05.Part1 do
  def run(puzzle) do
    {rules, updates} = parse(puzzle)

    updates
    |> Enum.filter(&valid?(&1, rules))
    |> Enum.map(&Enum.at(&1, &1 |> length |> div(2)))
    |> Enum.sum()
  end

  def parse(puzzle) do
    [rules, updates] = String.split(puzzle, "\n\n")

    rules =
      for rule <- String.split(rules, "\n"), reduce: MapSet.new() do
        acc ->
          [p1, p2] = String.split(rule, "|")
          MapSet.put(acc, {String.to_integer(p1), String.to_integer(p2)})
      end

    updates =
      for pages <- String.split(updates, "\n") do
        for page <- String.split(pages, ","),
            page = String.to_integer(page),
            do: page
      end

    {rules, updates}
  end

  def valid?(update, rules) do
    update
    |> Enum.reduce({[], true}, fn
      _page, {prev, false} ->
        {prev, false}

      page, {prev, _valid?} ->
        valid? = not Enum.any?(prev, &MapSet.member?(rules, {page, &1}))
        {[page | prev], valid?}
    end)
    |> elem(1)
  end
end
