defprotocol Zip do
  @moduledoc """
  The Zip interface allows all sorts of operations on collections. If you squint you might see an
  applicative.

  The collections need to have some sort of order for this interface to return stable results, so
  a good example is a list. The zip interface allows us, for example, to add elements from two lists
  together pairwise. What does pairwise mean? You take the first element in the first list, and the
  first element in the second list and add them together. Then the second elements in each list get
  added together and so on.

  ### Example

      iex> Zip.apply([1, 2], [1, 2], %Add{})
      [2, 4]
  """
  def apply(collection_1, collection_2, operation)
end

# What is the advantage of having the operations be data structures?
# I think I have been "defunctionalizing the continuation" without even realising?

defprotocol MapM do
  @moduledoc """
  This works like the Enum.map we know and love. We can use it like this, if provide the correct
  implementations for lists, addition of integers and decimals:

      iex> MapM.apply([1, 2, 3], %Add{value: 10})
      [11, 12, 13]

      iex> MapM.apply([1, 2, Decimal.new(3)], %Add{value: 10})
      [11, 12, #Decimal<13>]

      iex> MapM.apply([1, 2, Decimal.new(3)], %Add{value: Decimal.new(10)})
      [11, 12, #Decimal<13>]

      iex> MapM.apply([[1, 2, Decimal.new(3)]], %Add{value: 10})
      [[11, 12, #Decimal<13>]]
  """
  def apply(x, operation)
end

defimpl MapM, for: List do
  def apply(a, operation = %{mapm: mapm}) do
    Enum.map(a, fn x -> mapm.(x, operation) end)
  end

  def apply(a, fun) when is_function(fun) do
    Enum.map(a, fun)
  end
end
