defmodule StreamImplTest do
  use ExUnit.Case
  doctest Zip

  describe "apply/3" do
    test "Applies the given fun elementwise to the things in the stream" do
      a = Stream.concat([2, 4], [6])
      z = Stream.concat([2, 4], [6])
      result = Zip.apply(a, z, fn x, y -> x + y end)
      assert Enum.to_list(result) == [4, 8, 12]
    end
  end

  describe "apply/4" do
    test "Applies the given mod / fun elementwise to the things in the stream" do
      a = Stream.concat([2, 4], [6])
      z = Stream.concat([2, 4], [6])
      result = Zip.apply(a, z, Integer, :floor_div)
      assert Enum.to_list(result) == [1, 1, 1]
    end
  end

  defmodule Test do
    def thing(x, y, z) do
      x + y + z
    end
  end

  describe "apply/5" do
    test "Applies the given mod / fun args elementwise to the things in the stream" do
      result =
        Zip.apply(Stream.concat([2, 8], [6]), Stream.concat([2, 2], [6]), Test, :thing, [1])

      assert Enum.to_list(result) == [5, 11, 13]
    end
  end
end
