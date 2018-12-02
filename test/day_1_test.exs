defmodule Advent2018.Day1.Test do
  use ExUnit.Case
  alias Advent2018.Day1

  test "add_frequencies/1 adds rows together" do
    file = """
    +1
    -3
    +55
    """
    assert Day1.add_frequencies(file) == 53
  end

  test "add_frequencies/1 adds the rows in the file together" do
    assert Day1.add_frequencies() == 510
  end

  test "first_repeated_frequency/1 returns the first repeated frequency" do
    file = """
    +3
    +3
    +4
    -2
    -4
    """

    assert Day1.first_repeated_frequency(file) == 10
  end

  test "first_repeated_frequency/1 returns the first repeated frequency from the file" do
    assert Day1.first_repeated_frequency() == 69074
  end
end
