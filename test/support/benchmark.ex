defmodule Advent.Benchmark do
  def measure(function) do
    time =
      function
      |> :timer.tc()
      |> elem(0)
      |> Kernel./(1_000)

    IO.puts("runtime: #{time}ms")
  end
end
