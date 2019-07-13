defmodule ListImplTest do
  use ExUnit.Case
  doctest Zip

  describe "apply/3" do
    test "Applies the given fun elementwise to the things in the list" do
      assert Zip.apply(["TEST"], ["ING"], fn a, b -> a <> b end) == ["TESTING"]
    end
  end

  describe "apply/4" do
    test "Applies the given mod / fun elementwise to the things in the list" do
      assert Zip.apply(["TEST ING"], ["ING"], String, :bag_distance) == [0.375]
    end
  end

  describe "apply/5" do
    test "Applies the given mod / fun args elementwise to the things in the list" do
      assert Zip.apply([[1, 2, 3, 4], [5, 6, 7, 8]], [3, 2], Enum, :chunk_every, [3, :discard]) ==
               [[[1, 2, 3]], [[5, 6]]]
    end
  end
end
