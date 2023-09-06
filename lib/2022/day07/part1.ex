defmodule Advent.Y2022.Day07.Part1 do
  @root %{"/" => %{type: :dir, content: %{}}}

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> build_tree(@root)
    |> find_at_most(100_000)
  end

  def build_tree([], acc), do: acc
  def build_tree(["$ cd .." | _puzzle], acc), do: acc

  def build_tree(["$ cd " <> dir | puzzle], acc) do
    {index, _} =
      Enum.reduce_while(puzzle, {0, 0}, fn
        "$ cd ..", {index, 0} -> {:halt, {index, 0}}
        "$ cd ..", {index, depth} -> {:cont, {index + 1, depth - 1}}
        "$ cd " <> _dir, {index, depth} -> {:cont, {index + 1, depth + 1}}
        _instruction, {index, depth} -> {:cont, {index + 1, depth}}
      end)

    {dir_puzzle, remaining_puzzle} = Enum.split(puzzle, index + 1)
    content = build_tree(dir_puzzle, %{})
    total_size = Enum.reduce(content, 0, fn {_, %{size: size}}, acc -> acc + size end)
    acc = acc |> put_in([dir, :content], content) |> put_in([dir, :size], total_size)
    build_tree(remaining_puzzle, acc)
  end

  def build_tree(["$ ls" | puzzle], acc) do
    build_tree(puzzle, acc)
  end

  def build_tree(["dir " <> dir | puzzle], acc) do
    acc = Map.put(acc, dir, %{type: :dir, content: %{}})
    build_tree(puzzle, acc)
  end

  def build_tree([size_and_file | puzzle], acc) do
    [size, file] = String.split(size_and_file, " ")
    acc = Map.put(acc, file, %{type: :file, size: String.to_integer(size)})
    build_tree(puzzle, acc)
  end

  defp find_at_most(tree, max_size, acc \\ 0) do
    Enum.reduce(tree, acc, fn
      {_, %{type: :dir, size: size, content: tree}}, acc when size <= max_size ->
        find_at_most(tree, max_size, acc + size)

      {_, %{type: :dir, size: size, content: tree}}, acc when size > max_size ->
        find_at_most(tree, max_size, acc)

      _, acc ->
        acc
    end)
  end
end
