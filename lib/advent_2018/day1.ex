defmodule Advent2018.Day1 do
  @fixture Path.expand("./fixtures/day1.txt")

  def add_frequencies(file \\ @fixture) do
    file
    |> build_stream()
    |> Stream.map(&parse_row/1)
    |> Enum.sum()
  end

  def first_repeated_frequency(file \\ @fixture) do
    file
    |> build_stream()
    |> Stream.map(&parse_row/1)
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, &handle_frequency/2)
  end

  defp handle_frequency(incoming_frequency, {current_frequency, seen_frequencies}) do
    new_frequency = current_frequency + incoming_frequency

    if new_frequency in seen_frequencies do
      {:halt, new_frequency}
    else
      {:cont, {new_frequency, MapSet.put(seen_frequencies, new_frequency)}}
    end
  end

  defp build_stream(file) do
    file
    |> File.exists?()
    |> case do
      true -> File.stream!(file)
      false -> String.split(file, "\n") |> Enum.reject(&(&1 == ""))
    end
  end

  def parse_row(row) do
    {number, _} = Integer.parse(row)

    number
  end
end
