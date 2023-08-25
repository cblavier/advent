defmodule Advent.Y2022.Day05.Part2 do
  def run(puzzle) do
    [stacks, instructions] = String.split(puzzle, "\n\n")
    stacks = parse_stacks(stacks)
    instructions = parse_instructions(instructions)
    stacks |> move_stacks(instructions) |> Enum.map(&hd/1) |> Enum.join()
  end

  defp parse_stacks(stacks) do
    stacks = String.split(stacks, "\n")

    stacks
    |> Enum.take(length(stacks) - 1)
    |> Enum.map(&for(i <- 0..8, do: String.at(&1, i * 4 + 1)))
    |> Enum.zip_with(& &1)
    |> Enum.map(&for item <- &1, item != " ", do: item)
  end

  defp parse_instructions(instructions) do
    for instruction <- String.split(instructions, "\n") do
      ["move", count, "from", from, "to", to] = String.split(instruction, " ")
      %{count: String.to_integer(count), from: String.to_integer(from), to: String.to_integer(to)}
    end
  end

  defp move_stacks(stacks, instructions) do
    for instruction <- instructions, reduce: stacks do
      stacks -> run_instruction(stacks, instruction)
    end
  end

  defp run_instruction(stacks, %{count: count, from: from, to: to}) do
    {stacks, popped} = pop(stacks, from, count)
    push(stacks, popped, to)
  end

  defp pop(stacks, from, amount) do
    for {stack, index} <- Enum.with_index(stacks, 1), reduce: {[], nil} do
      {stacks, popped} ->
        if index == from do
          popped = Enum.slice(stack, 0, amount)
          stack = Enum.slice(stack, amount..-1)
          {stacks ++ [stack], popped}
        else
          {stacks ++ [stack], popped}
        end
    end
  end

  defp push(stacks, items, to) do
    for {stack, index} <- Enum.with_index(stacks, 1) do
      if index == to do
        items ++ stack
      else
        stack
      end
    end
  end
end
