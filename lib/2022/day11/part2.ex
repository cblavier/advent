defmodule Advent.Y2022.Day11.Part2 do
  def run(puzzle) do
    monkeys = parse_monkeys(puzzle)
    super_modulo = get_supermodulo(monkeys)

    monkeys =
      for _round <- 1..10_000, reduce: monkeys do
        monkeys ->
          items_acc = for monkey <- monkeys, into: %{}, do: {monkey.index, monkey.items}
          inspections_acc = for monkey <- monkeys, into: %{}, do: {monkey.index, monkey.inspections}

          {items_acc, inspections_acc} =
            for monkey <- monkeys, reduce: {items_acc, inspections_acc} do
              {items_acc, inspections_acc} ->
                for item <- Map.get(items_acc, monkey.index),
                    reduce: {items_acc, inspections_acc} do
                  {items_acc, inspections_acc} ->
                    worry = apply_operation(monkey.operation, item)
                    worry = rem(worry, super_modulo)

                    target_index =
                      if rem(worry, monkey.divider_test) == 0 do
                        monkey.if_true
                      else
                        monkey.if_false
                      end

                    items_acc =
                      items_acc
                      |> Map.update!(monkey.index, fn items -> Enum.reject(items, &(&1 == item)) end)
                      |> Map.update!(target_index, fn items -> [worry | items] end)

                    inspections_acc = Map.update!(inspections_acc, monkey.index, &(&1 + 1))
                    {items_acc, inspections_acc}
                end
            end

          for monkey <- monkeys do
            %{
              monkey
              | inspections: Map.get(inspections_acc, monkey.index),
                items: Map.get(items_acc, monkey.index)
            }
          end
      end

    monkeys
    |> Enum.map(& &1.inspections)
    |> IO.inspect()
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  defp parse_monkeys(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.chunk_every(7)
    |> Enum.with_index()
    |> Enum.map(fn {chunk, index} ->
      items =
        chunk
        |> Enum.at(1)
        |> String.split([": ", ", "])
        |> Enum.drop(1)
        |> Enum.map(&String.to_integer/1)

      operation = chunk |> Enum.at(2) |> String.split(": ") |> Enum.at(1)
      test = chunk |> Enum.at(3) |> String.split("by ") |> Enum.at(1) |> String.to_integer()
      if_true = chunk |> Enum.at(4) |> String.split("monkey ") |> Enum.at(1) |> String.to_integer()
      if_false = chunk |> Enum.at(5) |> String.split("monkey ") |> Enum.at(1) |> String.to_integer()

      %{
        index: index,
        items: items,
        operation: operation,
        divider_test: test,
        if_true: if_true,
        if_false: if_false,
        inspections: 0
      }
    end)
  end

  defp get_supermodulo(monkeys), do: monkeys |> Enum.map(& &1.divider_test) |> Enum.product()

  defp apply_operation("new = old * old", old), do: old * old
  defp apply_operation("new = old + " <> v, old), do: old + String.to_integer(v)
  defp apply_operation("new = old * " <> v, old), do: old * String.to_integer(v)
end
