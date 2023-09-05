defmodule Advent.Y2022.Day07.Part1 do
  # %{
  #   "foo" => %{type: :dir, content: %{ ... }},
  #   "bar" => %{type: :file, size: 10_0128}
  # ]

  # /
  #   a
  #   b.txt
  #   c.dat
  #   d

  # /
  #   a
  #     e
  #     f
  #     g
  #     h.lst
  #   b.txt
  #   c.dat
  #   d

  # /
  #   a
  #     e
  #     f
  #     g
  #     h.lst
  #   b.txt
  #   c.dat
  #   d

  @root %{"/" => %{type: :dir, content: %{}}}

  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> run_instruction(@root)
  end

  defp run_instruction([], acc), do: acc

  defp run_instruction(["$ cd .." | puzzle], _acc) do
    run_instruction(puzzle, %{})
  end

  defp run_instruction(["$ cd " <> dir | puzzle], acc) do
    IO.inspect("cd #{dir}")
    content = run_instruction(puzzle, %{})
    IO.inspect(content, label: "received #{dir} content")
    Map.put(acc, dir, content)
  end

  defp run_instruction(["$ ls" | puzzle], acc) do
    IO.inspect("ls")
    IO.inspect(acc)
    run_instruction(puzzle, acc)
  end

  defp run_instruction(["dir " <> dir | puzzle], acc) do
    acc = Map.put(acc, dir, %{type: :dir, content: %{}})
    IO.inspect(acc)
    run_instruction(puzzle, acc)
  end

  defp run_instruction([size_and_file | puzzle], acc) do
    IO.inspect(size_and_file)
    [size, file] = String.split(size_and_file, " ")
    acc = Map.put(acc, file, %{type: :file, size: String.to_integer(size)})
    run_instruction(puzzle, acc)
  end
end
