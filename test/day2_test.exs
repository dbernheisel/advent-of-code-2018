defmodule Advent2018.Day2.Test do
  use ExUnit.Case
  alias Advent2018.Day2
  @small_fixture_one """
  abcdef
  bababc
  abbcde
  abcccd
  aabcdd
  abcdee
  ababab
  """

  describe "find_checksum/1" do
    test "returns checksum of boxes" do
      assert Day2.find_checksum(@small_fixture_one) == 12
    end

    test "returns checksum of boxes in the file" do
      assert Day2.find_checksum() == 7872
    end
  end

  @small_fixture_two """
  abcde
  fghij
  klmno
  pqrst
  fguij
  axcye
  wvxyz
  """

  describe "find_common_letters/1" do
    test "returns the common letters of the two most-similar boxes" do
      assert Day2.find_common_letters(@small_fixture_two) == "fgij"
    end

    test "returns the common letters of the two most-similar boxes in the file" do
      assert Day2.find_common_letters() == "tjxmoewpdkyaihvrndfluwbzc"
    end
  end
end
