defmodule Advent2018.Day2 do
  @fixture Path.expand("./fixtures/day2.txt")
  @counters [2, 3]

  def find_checksum(file \\ @fixture) do
    file
    |> build_stream()
    |> Enum.reduce(%{}, &handle_box/2)
    |> Enum.reduce(1, &handle_results/2)
  end

  def find_common_letters(file \\ @fixture) do
    boxes =
      file
      |> build_stream()
      |> Enum.map(&id_graphemes/1)

    boxes
    |> Enum.reduce([], &(find_common_boxes(boxes, &1, &2)))
    |> handle_common_box_results
  end

  def find_common_boxes(boxes, box_outer, common_boxes) do
    boxes
    |> Enum.find(fn box_inner ->
      with difference <- List.myers_difference(box_outer, box_inner),
        del when not is_nil(del) <- difference[:del],
        1 <- Enum.count(difference, fn {op, _} -> op == :del end),
        1 <- length(del) do
        true
      else
        _ -> false
      end
    end)
    |> case do
      nil -> common_boxes
      common_box -> [common_box | common_boxes]
    end
  end

  def handle_common_box_results([box_one, box_two]) do
    List.myers_difference(box_one, box_two)
    |> Enum.filter(fn {op, _letters} ->  op == :eq end)
    |> Enum.reduce([], fn {_op, letters}, word -> [letters | word] end)
    |> Enum.reverse()
    |> List.flatten()
    |> Enum.join("")
  end

  defp handle_box(incoming_box_id, boxes) do
    incoming_box_counts = count_box_characters(incoming_box_id)

    Enum.reduce(@counters, boxes, fn counter, boxes ->
      {_, updated_boxes} =
        Map.get_and_update(boxes, counter, fn current_value ->
          if incoming_box_counts |> Map.values() |> Enum.any?(&(&1 == counter)) do
            {current_value, (current_value || 0) + 1}
          else
            {current_value, current_value}
          end
        end)

      updated_boxes
    end)
  end

  defp handle_results({_counter, number}, result) do
    number * result
  end

  defp count_box_characters(incoming_box_id) do
    incoming_box_id
    |> id_graphemes()
    |> Enum.reduce(%{}, fn character, character_counts ->
      Map.put(character_counts, character, (character_counts[character] || 0) + 1)
    end)
  end

  defp build_stream(file) do
    file
    |> File.exists?()
    |> case do
      true -> File.stream!(file)
      false -> String.split(file, "\n") |> Enum.reject(&(&1 == ""))
    end
  end

  defp id_graphemes(box_id) do
    box_id |> String.trim() |> String.graphemes()
  end
end
