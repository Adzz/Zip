defmodule StreamImplTest do
  use ExUnit.Case
  doctest Zip

  describe "add/2" do
    test "adds each element in the list elementwise" do
      a = Stream.concat([2, 4], [6])
      z = Stream.concat([2, 4], [6])
      assert Zip.apply(a, z, %Add{}) |> Enum.to_list() == [4, 8, 12]
    end
  end

  describe "subtract/2" do
    test "subtracts each element in the list elementwise" do
      result = Zip.apply(Stream.concat([2, 4], [6]), Stream.concat([2, 4], [6]), %Subtract{})
      assert Enum.to_list(result) == [0, 0, 0]
    end
  end

  describe "multiply/2" do
    test "multiplies each element in the list elementwise" do
      assert Zip.apply(Stream.concat([2, 4], [6]), Stream.concat([2, 4], [6]), %Multiply{})
             |> Enum.to_list() == [4, 16, 36]
    end
  end

  describe "divide/2" do
    test "divides each element in the list elementwise" do
      assert Zip.apply(Stream.concat([2, 8], [6]), Stream.concat([2, 2], [6]), %Divide{})
             |> Enum.to_list() == [1.0, 4.0, 1.0]
    end
  end
end
