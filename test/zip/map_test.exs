defmodule MapImplTest do
  use ExUnit.Case

  describe "add/2" do
    test "adds each element in the list elementwise" do
      assert Zip.apply(%{a: 2, c: 5}, %{a: 1, c: 3}, %Zip.Add{}) == %{a: 3, c: 8}
    end
  end

  describe "subtract/2" do
    test "subtracts each element in the list elementwise" do
      result = Zip.apply(%{a: 2, c: 5}, %{a: 1, c: 3}, %Subtract{})
      assert result == %{a: 1, c: 2}
    end
  end

  describe "multiply/2" do
    test "multiplies each element in the list elementwise" do
      assert Zip.apply(%{a: 2, c: 5}, %{a: 1, c: 3}, %Multiply{}) == %{a: 2, c: 15}
    end
  end

  describe "divide/2" do
    test "divides each element in the list elementwise" do
      assert Zip.apply(%{a: 2, c: 10}, %{a: 1, c: 2}, %Divide{}) == %{a: 2.0, c: 5.0}
    end
  end
end
