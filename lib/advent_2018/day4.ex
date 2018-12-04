defmodule GuardShift do
  defstruct [:guard_id, minutes: []]
end

defmodule ShiftMinute do
  defstruct [:minute, is_asleep: false]
end

defmodule Advent2018.Day4 do
  @fixture Path.expand("./fixtures/day4.txt")

  def find_weakest_checksum(file \\ @fixture) do
    {guard, minutes} =
      file
      |> build_stream()
      |> Enum.map(&parse_row/1)
      |> Enum.chunk_while([], &chunk_by_guard/2, &emit_shift/1)
      |> Enum.map(&build_guard_shift/1)
      |> group_by_sleep_minutes()
      |> Enum.max_by(fn {_guard, minutes} -> length(minutes) end)

    {common_minute, _} = minutes |> find_most_slept_minute()

    guard * common_minute
  end

  def find_most_common_guard_sleep_minute(file \\ @fixture) do
    {guard, {common_minute, _}} =
      file
      |> build_stream()
      |> Enum.map(&parse_row/1)
      |> Enum.chunk_while([], &chunk_by_guard/2, &emit_shift/1)
      |> Enum.map(&build_guard_shift/1)
      |> group_by_sleep_minutes()
      |> Enum.map(fn {guard, minutes} ->
        {
          guard,
          find_most_slept_minute(minutes)
        }
      end)
      |> Enum.max_by(fn {_guard, {_minute, count}} -> count end)

    guard * common_minute
  end

  defp find_most_slept_minute(minutes) do
    minutes
    |> Enum.reduce(%{}, fn
      %{minute: minute}, acc -> Map.update(acc, minute, 1, &(&1 + 1))
      _, acc -> acc
    end)
    |> Enum.max_by(fn {_minute, count} -> count end, fn -> {nil, 0} end)
  end

  defp group_by_sleep_minutes(shifts) do
    shifts
    |> Enum.group_by(& &1.guard_id, & &1.minutes)
    |> Enum.map(fn {guard, minutes} -> {guard, List.flatten(minutes)} end)
    |> Enum.map(fn {guard, minutes} -> {guard, Enum.filter(minutes, & &1.is_asleep)} end)
  end

  defp parse_row(row) do
    [date, time, action] =
      row
      |> String.replace("[", "")
      |> String.replace("]", "")
      |> String.split(" ", parts: 3)

    [
      date,
      String.split(time, ":") |> Enum.map(&String.to_integer/1),
      action
    ]
  end

  defp chunk_by_guard(row, []), do: {:cont, [row]}

  defp chunk_by_guard([_date, _time, action] = row, shift) do
    if action =~ "begins shift" do
      {:cont, Enum.reverse(shift), [row]}
    else
      {:cont, [row | shift]}
    end
  end

  def emit_shift([]), do: {:cont, []}
  def emit_shift(shift), do: {:cont, Enum.reverse(shift), []}

  defp build_guard_shift([[_, _, shift_start_action] | _] = actions) do
    %GuardShift{}
    |> put_guard(shift_start_action)
    |> put_minutes(actions)
  end

  defp put_guard(shift, shift_start_action) do
    guard_id = Regex.replace(~r/\D/, shift_start_action, "") |> String.to_integer()

    %{shift | guard_id: guard_id}
  end

  defp put_minutes(shift, [_on_shift | actions]) do
    sleeping_minutes =
      actions
      |> chunk_by_sleeping()
      |> Enum.reduce([], fn [[_, [_, sleep_start], _], [_, [_, sleep_end], _]], minutes ->
        [
          Enum.map(sleep_start..(sleep_end - 1), &%ShiftMinute{minute: &1, is_asleep: true})
          | minutes
        ]
      end)
      |> List.flatten()

    awake_minutes =
      Enum.map(
        Enum.to_list(0..59) -- Enum.map(sleeping_minutes, & &1.minute),
        fn minute -> %ShiftMinute{minute: minute} end
      )

    %{shift | minutes: Enum.sort_by(awake_minutes ++ sleeping_minutes, & &1.minute)}
  end

  defp chunk_by_sleeping(actions) do
    Enum.chunk_every(actions, 2)
  end

  defp build_stream(file) do
    file
    |> File.exists?()
    |> case do
      true -> File.read!(file)
      false -> file
    end
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.sort()
  end
end
