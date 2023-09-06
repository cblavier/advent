defmodule Advent.Y2022.Day07.Part2 do
  import Advent.Y2022.Day07.Part1

  @root %{"/" => %{type: :dir, content: %{}}}
  @total_space 70_000_000
  @target_free_space 30_000_000

  def run(puzzle) do
    tree = puzzle |> String.split("\n") |> build_tree(@root)
    taken_size = get_in(tree, ["/", :size])
    space_to_free = @target_free_space - (@total_space - taken_size)
    find_smallest_dir_to_delete(tree, space_to_free)
  end

  defp find_smallest_dir_to_delete(tree, space_to_free, candidate \\ @target_free_space) do
    Enum.reduce(tree, candidate, fn
      {_, %{type: :dir, size: size, content: tree}}, acc
      when size <= acc and size >= space_to_free ->
        find_smallest_dir_to_delete(tree, space_to_free, size)

      {_, %{type: :dir, size: _size, content: tree}}, acc ->
        find_smallest_dir_to_delete(tree, space_to_free, acc)

      _, acc ->
        acc
    end)
  end
end
