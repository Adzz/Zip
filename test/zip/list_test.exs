defmodule ListImplTest do
  use ExUnit.Case
  doctest Zip

  describe "add/2" do
    test "adds each element in the list elementwise" do
      assert Zip.apply([2, 4, 6], [2, 4, 6], %Zip.Add{}) == [4, 8, 12]
    end

    test "empty lists" do
      assert Zip.apply([], [], %Zip.Add{}) == []
    end
  end

  describe "subtract/2" do
    test "subtracts each element in the list elementwise" do
      assert Zip.apply([2, 4, 6], [2, 4, 6], %Subtract{}) == [0, 0, 0]
    end

    test "empty lists" do
      assert Zip.apply([], [], %Subtract{}) == []
    end
  end

  describe "multiply/2" do
    test "multiplies each element in the list elementwise" do
      assert Zip.apply([2, 4, 6], [2, 4, 6], %Multiply{}) == [4, 16, 36]
    end

    test "empty lists" do
      assert Zip.apply([], [], %Multiply{}) == []
    end
  end

  describe "divide/2" do
    test "divides each element in the list elementwise" do
      assert Zip.apply([2, 8, 6], [2, 2, 6], %Divide{}) == [1.0, 4.0, 1.0]
    end

    test "empty lists" do
      assert Zip.apply([], [], %Divide{}) == []
    end
  end
end
