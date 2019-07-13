defmodule MapImplTest do
  use ExUnit.Case
  doctest Zip

  describe "apply/3" do
    test "Applies the given fun elementwise to the things in the list" do
      assert Zip.apply(%{z: "TEST"}, %{z: "ING"}, fn a, b -> a <> b end) == %{z: "TESTING"}
    end
  end

  describe "apply/4" do
    test "Applies the given mod / fun elementwise to the things in the list" do
      assert Zip.apply(%{z: "TEST ING"}, %{z: "ING"}, String, :bag_distance) == %{z: 0.375}
    end
  end

  describe "apply/5" do
    test "Applies the given mod / fun args elementwise to the things in the list" do
      assert Zip.apply(%{z: [1]}, %{z: 1}, Enum, :chunk_every, [3, :discard]) == %{z: [[1]]}
    end
  end
end
