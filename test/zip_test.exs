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
    test "subtracts each element in the list elementwise" do
      assert Zip.multiply([2, 4, 6], [2, 4, 6]) == [4, 16, 36]
    end

    test "empty lists" do
      assert Zip.multiply([], []) == []
    end

    test "differing list lengths" do
      assert_raise Zip.CollectionsOfDifferentSizes, fn -> Zip.multiply([1, 2], [1]) end
    end
  end
end
