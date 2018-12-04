defmodule Advent2018.Day1.Test do
  use ExUnit.Case
  alias Advent2018.Day1
  @small_fixture_one """
  +1
  -3
  +55
  """

  describe "add_frequencies/1" do
    test "returns sum of rows values" do
      assert Day1.add_frequencies(@small_fixture_one) == 53
    end

    test "returns sum of row values from file" do
      assert Day1.add_frequencies() == 510
    end
  end

  @small_fixture_two """
  +3
  +3
  +4
  -2
  -4
  """

  describe "first_repeated_frequency/1" do
    test "returns the first repeated frequency" do
      assert Day1.first_repeated_frequency(@small_fixture_two) == 10
    end

    test "returns the first repeated frequency from the file" do
      assert Day1.first_repeated_frequency() == 69074
    end
  end
end
