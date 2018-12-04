defmodule Advent2018.Day3.Test do
  use ExUnit.Case
  alias Advent2018.Day3
  @small_fixture """
  #1 @ 1,3: 4x4
  #2 @ 3,1: 4x4
  #3 @ 5,5: 2x2
  """

  describe "count_overlaps/1" do
    test "returns number of overlapping square inches" do
      assert Day3.count_overlaps(@small_fixture) == 4
    end

    test "returns number of overlapping square inches from file" do
      assert Day3.count_overlaps() == 112378
    end
  end

  describe "find_non_overlapped_claim/1" do
    test "returns the square id of non-overlapped" do
      assert Day3.non_overlapped_claim_id(@small_fixture) == "3"
    end

    test "returns the square id of non-overlapped from file" do
      assert Day3.non_overlapped_claim_id() == "603"
    end
  end
end
