defmodule Advent.Benchmark do
  def measure(function) do
    {time, result} = :timer.tc(function)
    IO.puts("runtime: #{time / 1000}ms")
    result
  end
end
