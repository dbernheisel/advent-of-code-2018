defmodule Advent2018.Day2.Test do
  use ExUnit.Case
  alias Advent2018.Day2

  test "find_checksum/1 multiplies boxes together" do
    file = """
    abcdef
    bababc
    abbcde
    abcccd
    aabcdd
    abcdee
    ababab
    """

    assert Day2.find_checksum(file) == 12
  end

  test "find_checksum/1 multiplies boxes together in the file" do
    assert Day2.find_checksum() == 7872
  end

  test "find_common_letters/1 returns the common letters of the twe most-similar boxes" do
    file = """
    abcde
    fghij
    klmno
    pqrst
    fguij
    axcye
    wvxyz
    """

    assert Day2.find_common_letters(file) == "fgij"
  end

  test "find_common_letters/1 returns the common letters of the twe most-similar boxes from the file" do
    assert Day2.find_common_letters() == "tjxmoewpdkyaihvrndfluwbzc"
  end
end
