defmodule Advent2018.Day4.Test do
  use ExUnit.Case
  alias Advent2018.Day4
  @small_fixture """
  [1518-11-01 00:00] Guard #10 begins shift
  [1518-11-01 00:05] falls asleep
  [1518-11-01 00:25] wakes up
  [1518-11-01 00:30] falls asleep
  [1518-11-01 00:55] wakes up
  [1518-11-01 23:58] Guard #99 begins shift
  [1518-11-02 00:40] falls asleep
  [1518-11-02 00:50] wakes up
  [1518-11-03 00:05] Guard #10 begins shift
  [1518-11-03 00:24] falls asleep
  [1518-11-03 00:29] wakes up
  [1518-11-04 00:02] Guard #99 begins shift
  [1518-11-04 00:36] falls asleep
  [1518-11-04 00:46] wakes up
  [1518-11-05 00:03] Guard #99 begins shift
  [1518-11-05 00:45] falls asleep
  [1518-11-05 00:55] wakes up
  """

  describe "find_weakest_checksum/1" do
    test "returns checksum of guard id and most reliably asleep minute" do
      assert Day4.find_weakest_checksum(@small_fixture) == 240
    end

    test "returns checksum of guard id and most reliable asleep minute from file" do
      assert Day4.find_weakest_checksum() == 21083
    end
  end

  describe "find_most_common_guard_sleep_minute/1" do
    test "returns checksum of guard id and most reliably asleep minute" do
      assert Day4.find_most_common_guard_sleep_minute(@small_fixture) == 4455
    end

    test "returns checksum of guard id and most reliable asleep minute from file" do
      assert Day4.find_most_common_guard_sleep_minute() == 53024
    end
  end
end
