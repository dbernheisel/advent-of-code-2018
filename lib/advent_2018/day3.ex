defmodule Advent2018.Day3.Spot do
  defstruct [:x, :y]
end

defmodule Advent2018.Day3 do
  @fixture Path.expand("./fixtures/day3.txt")
  defstruct [:id, :width, :height, :top_left_x, :top_left_y, spots: []]

  def count_overlaps(file \\ @fixture) do
    {dupes, _} =
      file
      |> build_stream()
      |> Stream.map(&parse_row/1)
      |> Stream.map(&build_claim/1)
      |> Enum.reduce({MapSet.new(), MapSet.new()}, &find_duplicates/2)
    Enum.count(dupes)
  end

  defp parse_row(row) do
    row
    |> String.trim()
    |> String.replace(":", "")
    |> String.replace("@ ", "")
    |> String.split(" ")
  end

  defp build_claim(["#" <> id, position, size]) do
    %__MODULE__{
      id: id,
      width: parse_width(size),
      height: parse_height(size),
      top_left_x: parse_x(position),
      top_left_y: parse_y(position)
    } |> mark_spots()
  end

  defp find_duplicates(claim, {dupes, spots}) do
    {
      MapSet.union(dupes, MapSet.intersection(claim.spots, spots)),
      MapSet.union(claim.spots, spots)
    }
  end

  defp mark_spots(row) do
    %{row | spots: MapSet.new(generate_spots(row))}
  end

  defp generate_spots(%{top_left_x: x, top_left_y: y, width: width, height: height}) do
    for x <- (x..x + width - 1),
      y <- (y..y + height - 1),
      do: %Advent2018.Day3.Spot{x: x, y: y}
  end

  defp parse_x(position) do
    position
    |> String.split(",")
    |> List.first()
    |> String.to_integer()
  end

  defp parse_y(position) do
    position
    |> String.split(",")
    |> List.last()
    |> String.to_integer()
  end

  def parse_width(size) do
    size
    |> String.split("x")
    |> List.first()
    |> String.to_integer()
  end

  def parse_height(size) do
    size
    |> String.split("x")
    |> List.last()
    |> String.to_integer()
  end

  defp build_stream(file) do
    file
    |> File.exists?()
    |> case do
      true -> File.stream!(file)
      false -> String.split(file, "\n") |> Enum.reject(&(&1 == ""))
    end
  end
end
