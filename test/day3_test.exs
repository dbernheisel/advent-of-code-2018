defmodule Advent2018.Day3.Test do
  use ExUnit.Case
  alias Advent2018.Day3

  test "count_overlaps/1 returns number of overlapping square inches" do
    file = """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
    """

    assert Day3.count_overlaps(file) == 4
  end

  test "count_overlaps/1 returns number of overlapping square inches from file" do
    assert Day3.count_overlaps() == 112378
  end

  test "find_non_overlapped_claim/1 returns the square id of non-overlapped" do
    file = """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
    """

    assert Day3.non_overlapped_claim_id(file) == "3"
  end

  test "find_non_overlapped_claim/1 returns the square id of non-overlapped from file" do
    assert Day3.non_overlapped_claim_id() == "603"
  end
end
