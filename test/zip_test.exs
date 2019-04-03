defmodule ZipTest do
  use ExUnit.Case
  doctest Zip

  describe "add/2 - List" do
    test "adds each element in the list elementwise" do
      assert Zip.add([2, 4, 6], [2, 4, 6]) == [4, 8, 12]
    end

    test "empty lists" do
      assert Zip.add([], []) == []
    end

    test "differing list lengths" do
      assert_raise Zip.CollectionsOfDifferentSizes, fn -> Zip.add([1, 2], [1]) end
    end
  end

  describe "subtract/2 - List" do
    test "subtracts each element in the list elementwise" do
      assert Zip.subtract([2, 4, 6], [2, 4, 6]) == [0, 0, 0]
    end

    test "empty lists" do
      assert Zip.subtract([], []) == []
    end

    test "differing list lengths" do
      assert_raise Zip.CollectionsOfDifferentSizes, fn -> Zip.subtract([1, 2], [1]) end
    end
  end

  describe "multiply/2 - List" do
    test "multiplies each element in the list elementwise" do
      assert Zip.multiply([2, 4, 6], [2, 4, 6]) == [4, 16, 36]
    end

    test "empty lists" do
      assert Zip.multiply([], []) == []
    end

    test "differing list lengths" do
      assert_raise Zip.CollectionsOfDifferentSizes, fn -> Zip.multiply([1, 2], [1]) end
    end
  end

  describe "divide/2 - List" do
    test "divides each element in the list elementwise" do
      assert Zip.divide([2, 8, 6], [2, 2, 6]) == [1.0, 4.0, 1.0]
    end

    test "empty lists" do
      assert Zip.divide([], []) == []
    end

    test "differing list lengths" do
      assert_raise Zip.CollectionsOfDifferentSizes, fn -> Zip.divide([1, 2], [1]) end
    end
  end

  describe "apply/3 - List" do
    test "Applies the given fun elementwise to the things in the list" do
      assert Zip.apply(["TEST"], ["ING"], fn a, b -> a <> b end) == ["TESTING"]
    end
  end

  describe "apply/4 - List" do
    test "Applies the given mod / fun elementwise to the things in the list" do
      assert Zip.apply(["TEST ING"], ["ING"], String, :bag_distance) == [0.375]
    end
  end

  describe "apply/5 - List" do
    test "Applies the given mod / fun args elementwise to the things in the list" do
      assert Zip.apply([[1, 2, 3, 4], [5, 6, 7, 8]], [3, 2], Enum, :chunk_every, [3, :discard]) ==
               [[[1, 2, 3]], [[5, 6]]]
    end
  end
end
